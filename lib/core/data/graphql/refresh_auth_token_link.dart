import 'dart:async';

import 'package:collection/collection.dart';
import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/data/graphql/auth_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/model/gql_auth_result.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

///https://github.com/gql-dart/gql/blob/1884596904a411363165bcf3c7cfa9dcc2a61c26/examples/gql_example_http_auth_link/lib/http_auth_link.dart
class RefreshAuthTokenLink extends gql.Link {
  RefreshAuthTokenLink(
    this._refreshTokenClient,
    this._failureMapper,
    this._configProvider,
    this._saveAuthTokenUseCase,
    this._getAuthTokenUseCase,
    this._logger,
  );

  static Completer<gql.QueryResult<GqlAuthResult>>? _refreshCompleter;

  final GraphQLLogger _logger;
  final GraphQLFailureMapper _failureMapper;
  final gql.GraphQLClient _refreshTokenClient;
  final EnvironmentConfigProvider _configProvider;
  final SaveAuthTokenUseCase _saveAuthTokenUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;

  late final _handleErrorLink = gql.ErrorLink(
    onException: _onException,
    onGraphQLError: _onGraphQLError,
  );

  @override
  Stream<gql.Response> request(gql.Request request, [gql.NextLink? forward]) {
    return _handleErrorLink.request(request, forward);
  }

  Stream<gql.Response>? _onException(
    gql.Request request,
    gql.NextLink forward,
    gql.LinkException exception,
  ) async* {
    final mappedException = _failureMapper.mapException(exception);
    if (mappedException.isUnauthenticated) {
      //we ignore the errors in refresh and just proceed with normal request flow
      await _refreshToken(
        request,
        exception,
      );
    }

    yield* forward(request);
  }

  Stream<gql.Response>? _onGraphQLError(
    gql.Request request,
    gql.NextLink forward,
    gql.Response response,
  ) async* {
    final unauthenticatedException = (response.errors ?? [])
        .map((e) => _failureMapper.mapException(e))
        .firstWhereOrNull((element) => element.isUnauthenticated);
    if (unauthenticatedException != null) {
      //we ignore the errors in refresh and just proceed with normal request flow
      await _refreshToken(
        request,
        unauthenticatedException,
      );
    }
    yield* forward(request);
  }

  /// Returns true if refresh token succeeds, false otherwise.
  Future<bool> _refreshToken(
    gql.Request request,
    Object exception,
  ) async {
    try {
      final response = await _performRefresh();

      return await _saveAuthTokenUseCase.execute(authToken: response.authToken).asyncFold(
        (fail) {
          return false;
        },
        (success) {
          return true;
        },
      );
    } catch (ex) {
      return false;
    }
  }

  Future<gql.QueryResult<GqlAuthResult>> _performRefresh() async {
    var completer = _refreshCompleter;
    if (completer?.isCompleted == false) {
      debugLog("There is already 'refreshToken' request in progress, waiting until its finished", this);
      //this makes sure we run only one refresh-token request at a time, so that if multiple concurrent requests fail,
      // we don't run the refresh token
      return completer!.future;
    }
    completer = Completer<gql.QueryResult<GqlAuthResult>>();
    _refreshCompleter = completer;
    debugLog("Refreshing accessToken...", this);
    final tokensResult = await _getAuthTokenUseCase.execute();
    if (tokensResult.isFailure) {
      logError("fail when getting tokens from storage: ${tokensResult.getFailure()}", logToCrashlytics: false);
      completer.completeError(tokensResult.getFailure()!);
      return completer.future;
    }
    final tokenResult = tokensResult.getSuccess()!;
    if (tokenResult.accessToken.isEmpty) {
      logError("missing accessToken, nothing to refresh", logToCrashlytics: false);
      completer.completeError("Response is missing accessToken: $tokenResult");
      return completer.future;
    }
    var response = await _refreshTokenRequest(tokenResult);
    if (response.hasException) {
      logError(response.exception, logToCrashlytics: false);
      //yielding original's request exception, not the refresh token's one
      completer.completeError(response.exception!);
      return completer.future;
    }
    completer.complete(response);
    return completer.future;
  }

  Future<gql.QueryResult<GqlAuthResult>> _refreshTokenRequest(AuthToken tokens) async {
    final variables = {
      'accessToken': tokens.accessToken,
      // for legacy purposes, users who don't have refresh token (the ones using the older version
      // of the app that didn't support refresh tokens)
      // can use their access token as refresh token and they'll receive proper refresh token in response
      'refreshToken': tokens.refreshToken.isEmpty ? tokens.accessToken : tokens.refreshToken,
    };
    final doc = refreshTokenMutation(
      includeDebugOption: await _configProvider.shouldUseShortLivedAuthTokens(),
    );
    final requestId = _logger.logRequest(doc: doc, vars: variables);
    final response = await _refreshTokenClient.mutate(
      gql.MutationOptions(
        document: gql.gql(
          doc,
        ),
        parserFn: (json) {
          return GqlAuthResult.fromJson((json['refreshTokens'] as Map).cast());
        },
        variables: variables,
      ),
    );
    response.isOptimistic;
    _logger.logResponse(requestId: requestId, result: response);
    return response;
  }
}

extension QueryResultAuthToken on gql.QueryResult<GqlAuthResult> {
  AuthToken get authToken {
    return parsedData?.authInfo.toDomain() ?? const AuthToken.empty();
  }
}
