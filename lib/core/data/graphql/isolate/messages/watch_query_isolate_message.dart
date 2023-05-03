import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class WatchQueryIsolateMessage<T> implements GraphQLIsolateMessage<CacheableResult<GraphQLFailure, T>?> {
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
    TypedSendPort<CacheableResult<GraphQLFailure, T>?> responsePort,
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
        responsePort.send(event.castSuccess());
      },
      onDone: () {
        responsePort.send(null);
      },
      onError: (error) {
        responsePort.send(CacheableResult(result: failure(GraphQLFailure.unknown(error))));
      },
    );
  }

  @override
  TypedSendPort<CacheableResult<GraphQLFailure, T>?> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
