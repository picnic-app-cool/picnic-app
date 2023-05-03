import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class QueryIsolateMessage<T> implements GraphQLIsolateMessage<Either<GraphQLFailure, T>> {
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
    TypedSendPort<Either<GraphQLFailure, T>> responsePort,
  ) async {
    final result = await isolate.gqlExecutor.query(
      document: document,
      variables: variables,
      parseData: parseData,
    );
    responsePort.send(result.mapSuccess((value) => value as T));
  }

  @override
  TypedSendPort<Either<GraphQLFailure, T>> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
