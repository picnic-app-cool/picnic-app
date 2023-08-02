import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/isolate/graphql_executor_result.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';

class QueryIsolateMessage<T> implements GraphQLIsolateMessage<GraphQLExecutorResult<T>> {
  const QueryIsolateMessage({
    required this.document,
    required this.parseData,
    required this.variables,
  });

  final String document;
  final dynamic Function(Map<String, dynamic> data) parseData;
  final Map<String, dynamic> variables;

  @override
  Future<void> handleMessageInIsolate(
    GraphQLIsolate isolate,
    TypedSendPort<GraphQLExecutorResult<T>> responsePort,
  ) async {
    final result = await isolate.gqlExecutor.query(
      document: document,
      variables: variables,
      parseData: parseData,
    );
    final executorResult = GraphQLExecutorResult<T>(
      cacheableResult: result.cacheableResult.mapSuccess((value) => value as T),
      response: result.response,
    );
    responsePort.send(executorResult);
  }

  @override
  TypedSendPort<GraphQLExecutorResult<T>> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
