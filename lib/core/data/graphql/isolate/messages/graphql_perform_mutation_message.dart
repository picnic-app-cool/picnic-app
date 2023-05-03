import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class GraphQLPerformMutationMessage<T> implements GraphQLIsolateMessage<Either<GraphQLFailure, T>> {
  GraphQLPerformMutationMessage(
    this.document,
    this.parseData,
    this.variables,
  );

  final String document;
  final dynamic Function(Map<String, dynamic> data) parseData;
  final Map<String, dynamic> variables;

  @override
  Future<void> handleMessageInIsolate(
    GraphQLIsolate isolate,
    TypedSendPort<Either<GraphQLFailure, T>> responsePort,
  ) async {
    final result = await isolate.gqlExecutor.mutate(
      document: document,
      parseData: parseData,
      variables: variables,
    );
    responsePort.send(result.mapSuccess((it) => it as T));
  }

  @override
  TypedSendPort<Either<GraphQLFailure, T>> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
