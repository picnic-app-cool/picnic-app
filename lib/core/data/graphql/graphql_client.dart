import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/graphql_unauthenticated_failure_handler.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_manager.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_perform_mutation_message.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/query_isolate_message.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/watch_query_isolate_message.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/data/hive/hive_path_provider.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';

class GraphQLClient {
  GraphQLClient(
    this._authTokenRepository,
    this.unauthenticatedFailureHandler,
    this.hivePathProvider,
  );

  @visibleForTesting
  final GraphQLUnauthenticatedFailureHandler unauthenticatedFailureHandler;
  final HivePathProvider hivePathProvider;

  @visibleForTesting
  final isolateManager = GraphQLIsolateManager();

  Completer<void>? _isInitializedCompleter;
  final AuthTokenRepository _authTokenRepository;

  Future<Either<GraphQLFailure, T>> query<T>({
    required String document,
    required T Function(Map<String, dynamic> data) parseData,
    Map<String, dynamic> variables = const {},
  }) async {
    await _ensureIsolateInitialized();
    return isolateManager
        .sendMessageToIsolate(
          QueryIsolateMessage<T>(
            document: document,
            parseData: parseData,
            variables: variables,
          ),
        )
        .first;
  }

  Stream<CacheableResult<GraphQLFailure, T>> watchQuery<T>({
    required String document,
    required T Function(Map<String, dynamic> data) parseData,
    Map<String, dynamic> variables = const {},
    WatchQueryOptions options = const WatchQueryOptions.defaultOptions(),
  }) async* {
    await _ensureIsolateInitialized();
    final stream = isolateManager.sendMessageToIsolate(
      WatchQueryIsolateMessage<T>(
        document: document,
        parseData: parseData,
        variables: variables,
        options: options,
      ),
    );
    await for (final result in stream) {
      if (result == null) {
        return;
      }
      yield result;
    }
  }

  Future<Either<GraphQLFailure, T>> mutate<T>({
    required String document,
    required T Function(Map<String, dynamic> data) parseData,
    Map<String, dynamic> variables = const {},
  }) async {
    await _ensureIsolateInitialized();
    return isolateManager
        .sendMessageToIsolate(
          GraphQLPerformMutationMessage<T>(
            document,
            parseData,
            variables,
          ),
        )
        .first;
  }

  void dispose() {
    isolateManager.dispose();
    _isInitializedCompleter = null;
  }

  Future<void> _ensureIsolateInitialized() async {
    if (_isInitializedCompleter == null) {
      _isInitializedCompleter = Completer();
      await isolateManager.startGraphQLIsolate(
        _authTokenRepository,
        unauthenticatedFailureHandler,
        hivePathProvider,
      );
      _isInitializedCompleter!.complete();
    } else {
      return _isInitializedCompleter!.future;
    }
  }
}
