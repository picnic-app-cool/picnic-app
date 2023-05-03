import 'dart:async';
import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';

class ListenToUnauthenticatedMessage implements GraphQLIsolateMessage<UnauthenticatedIsolateResponse> {
  const ListenToUnauthenticatedMessage();

  @override
  TypedSendPort<UnauthenticatedIsolateResponse> buildTypedSendPort(SendPort sendPort) =>
      TypedSendPort<UnauthenticatedIsolateResponse>(sendPort);

  @override
  Future<void> handleMessageInIsolate(
    GraphQLIsolate isolate,
    TypedSendPort<UnauthenticatedIsolateResponse> responsePort,
  ) async {
    final completer = Completer<void>();
    final receivePort = ReceivePort();
    isolate.sessionInvalidatedListenersContainer.registerOnSessionInvalidatedListener((tokenHashCode) {
      responsePort.send(UnauthenticatedIsolateResponse(receivePort.sendPort, tokenHashCode));
      return completer.future;
    });
    await receivePort.first;
    completer.complete();
  }
}

class UnauthenticatedIsolateResponse {
  const UnauthenticatedIsolateResponse(
    this.sendPort,
    this.tokenHashCode,
  );

  final SendPort sendPort;
  final int? tokenHashCode;
}
