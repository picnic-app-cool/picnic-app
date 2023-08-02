import 'dart:async';

import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/data/graphql/graphql_client_factory.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/graphql_unauthenticated_failure_handler.dart';
import 'package:picnic_app/core/data/graphql/graphql_variables_processor.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_executor_result.dart';
import 'package:picnic_app/core/data/graphql/model/gql_extensions.dart';
import 'package:picnic_app/core/data/graphql/model/graphql_response.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';

class GraphQLExecutor {
  GraphQLExecutor(
    this._failureMapper,
    this._unauthenticatedFailureHandler,
    this._variablesProcessor,
    this._graphqlClientFactory,
    this._logger,
    this._currentTimeProvider,
  );

  final GraphqlClientFactory _graphqlClientFactory;
  final GraphQLFailureMapper _failureMapper;
  final GraphQLUnauthenticatedFailureHandler _unauthenticatedFailureHandler;
  final GraphQLVariablesProcessor _variablesProcessor;
  final GraphQLLogger _logger;
  final CurrentTimeProvider _currentTimeProvider;
  gql.GraphQLClient? _client;

  Future<GraphQLExecutorResult<T>> query<T>({
    required String document,
    required T Function(Map<String, dynamic> data) parseData,
    Map<String, dynamic> variables = const {},
  }) async {
    return watchQuery(
      document: document,
      parseData: parseData,
      variables: variables,
      options: const WatchQueryOptions(
        cachePolicy: CachePolicy.noCache,
        continueWatchingAfterNetworkResponse: false,
        pollInterval: Duration.zero,
      ),
    ).networkResult;
  }

  Stream<GraphQLExecutorResult<T>> watchQuery<T>({
    required String document,
    required T Function(Map<String, dynamic> data) parseData,
    Map<String, dynamic> variables = const {},
    WatchQueryOptions options = const WatchQueryOptions.defaultOptions(),
  }) async* {
    try {
      final client = await _ensureGraphQLClient();
      // ignore: prefer-trailing-comma
      final gqlOptions = await _buildWatchableOptions(document, variables, options);
      final requestId = _logger.logRequest(doc: document, vars: variables);
      final executionDate = _currentTimeProvider.currentTime;
      final observableQuery = client.watchQuery<GraphQlResponse>(gqlOptions);
      yield* observableQuery.stream

          /// 'loading' result brings no valuable information, thus we're dropping it
          .where((event) {
            return event.source != gql.QueryResultSource.loading;
          })
          .map(
            (result) => GraphQLExecutorResult<T>(
              // ignore: prefer-trailing-comma
              cacheableResult: _mapQueryResult(requestId, result, executionDate, parseData),
              response: result,
            ),
          )
          .transform(
            _streamTransformer(
              options,
              gqlOptions,
              observableQuery,
            ),
          );
    } catch (ex, stack) {
      logError(ex, stack: stack);
      yield GraphQLExecutorResult(
        cacheableResult: await _handleFailure(ex, stackTrace: stack),
      );
    }
  }

  Future<GraphQLExecutorResult<T>> mutate<T>({
    required String document,
    required T Function(Map<String, dynamic> data) parseData,
    Map<String, dynamic> variables = const {},
  }) async {
    final client = await _ensureGraphQLClient();
    final vars = await _variablesProcessor.processVariablesMap(variables);

    try {
      return await _performMutate(
        document,
        vars.getOrElse(() => const {}),
        client,
        parseData,
      );
    } catch (ex, stack) {
      final failureResult = await _handleFailure<T>(ex, stackTrace: stack);
      return GraphQLExecutorResult(
        cacheableResult: failureResult,
      );
    }
  }

  Future<gql.WatchQueryOptions<GraphQlResponse>> _buildWatchableOptions(
    String document,
    Map<String, dynamic> variables,
    WatchQueryOptions options,
  ) async {
    return gql.WatchQueryOptions(
      eagerlyFetchResults: true,
      parserFn: (json) => GraphQlResponse.fromJson(json),
      document: gql.gql(document),
      variables: variables,
      pollInterval: options.pollInterval,
      fetchPolicy: GqlCachePolicyExtensions.fromCachePolicy(options.cachePolicy),
      context: await _prepareContext(),
    );
  }

  StreamTransformer<GraphQLExecutorResult<T>, GraphQLExecutorResult<T>> _streamTransformer<T>(
    WatchQueryOptions options,
    gql.WatchQueryOptions<GraphQlResponse> gqlOptions,
    gql.ObservableQuery<GraphQlResponse> observableQuery,
  ) {
    return StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(data);
        if (data.cacheableResult.source == CacheableSource.network && !options.continueWatchingAfterNetworkResponse) {
          observableQuery.close();
          sink.close();
        }
      },
      handleError: (
        error,
        stack,
        sink,
      ) async {
        final cacheableResult = await _handleFailure<T>(
          error,
          request: gqlOptions.asRequest,
          stackTrace: stack,
        );
        sink.add(GraphQLExecutorResult(cacheableResult: cacheableResult));
        observableQuery.close();
        sink.close();
      },
    );
  }

  CacheableResult<GraphQLFailure, T> _mapQueryResult<T>(
    String requestId,
    gql.QueryResult<GraphQlResponse> result,
    DateTime executionDate,
    T Function(Map<String, dynamic> data) parseData,
  ) {
    _logger.logResponse(
      requestId: requestId,
      result: result,
      executionDate: executionDate,
    );
    if (result.hasException) {
      throw result.exception!;
    }
    return CacheableResult(
      result: success(parseData(result.parsedData?.data ?? {})),
      source: result.source?.toCacheableSource(),
    );
  }

  Future<gql.Context> _prepareContext() async {
    return gql.Context.fromList([
      await _unauthenticatedFailureHandler.prepareContextEntry(),
    ]);
  }

  Future<CacheableResult<GraphQLFailure, T>> _handleFailure<T>(
    Object? exception, {
    gql.Request? request,
    gql.QueryResult<GraphQlResponse>? result,
    StackTrace? stackTrace,
  }) async {
    stackTrace ??= StackTrace.current;
    logError(exception, stack: stackTrace);
    final graphFailure = _failureMapper.mapException(exception, StackTrace.current);
    if (graphFailure.isUnauthenticated) {
      await _unauthenticatedFailureHandler.handle(
        tokenHashCode: request?.context.entry<GraphQLUnauthenticatedContextEntry>()?.tokenHashCode,
      );
    }
    return CacheableResult(result: failure(graphFailure), source: result?.source?.toCacheableSource());
  }

  Future<gql.GraphQLClient> _ensureGraphQLClient() async {
    return _client ??= await _graphqlClientFactory.createClient();
  }

  //ignore: long-parameter-list
  Future<GraphQLExecutorResult<T>> _performMutate<T>(
    String document,
    Map<String, dynamic> vars,
    gql.GraphQLClient client,
    T Function(Map<String, dynamic> data) parseData,
  ) async {
    final options = gql.MutationOptions(
      parserFn: (json) => GraphQlResponse.fromJson(json),
      document: gql.gql(document),
      variables: vars,
      fetchPolicy: gql.FetchPolicy.noCache,
      context: await _prepareContext(),
    );

    final requestId = _logger.logRequest(doc: document, vars: vars);

    final executionDate = _currentTimeProvider.currentTime;
    final result = await client.mutate<GraphQlResponse>(
      options,
    );
    //ignore: prefer-trailing-comma
    _logger.logResponse(requestId: requestId, result: result, executionDate: executionDate);

    if (result.hasException) {
      final handledResult = await _handleFailure<T>(
        result.exception,
        result: result,
        request: options.asRequest,
      );
      return GraphQLExecutorResult(
        cacheableResult: handledResult,
        response: result,
      );
    }

    return GraphQLExecutorResult(
      cacheableResult: CacheableResult(
        result: success(parseData(result.parsedData?.data ?? {})),
      ),
    );
  }
}
