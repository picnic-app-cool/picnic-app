import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_executor_result.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class WatchQueryIsolateMessage<T> implements GraphQLIsolateMessage<GraphQLExecutorResult<T>?> {
  WatchQueryIsolateMessage({
    required this.document,
    required this.parseData,
    required this.variables,
    required this.options,
  });

  final String document;
  final dynamic Function(Map<String, dynamic> data) parseData;
  final Map<String, dynamic> variables;
  final WatchQueryOptions options;

  @override
  void handleMessageInIsolate(
    GraphQLIsolate isolate,
    TypedSendPort<GraphQLExecutorResult<T>?> responsePort,
  ) {
    isolate.gqlExecutor
        .watchQuery(
      document: document,
      variables: variables,
      parseData: parseData,
      options: options,
    )
        .listen(
      (event) {
        responsePort.send(
          GraphQLExecutorResult<T>(
            cacheableResult: event.cacheableResult.mapSuccess((value) => value as T),
            response: event.response,
          ),
        );
      },
      onDone: () {
        responsePort.send(null);
      },
      onError: (error) {
        responsePort.send(
          GraphQLExecutorResult(
            cacheableResult: CacheableResult(result: failure(GraphQLFailure.unknown(error))),
          ),
        );
      },
    );
  }

  @override
  TypedSendPort<GraphQLExecutorResult<T>?> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
