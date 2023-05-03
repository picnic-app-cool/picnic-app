import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';

class InitMessage implements GraphQLIsolateMessage<void> {
  const InitMessage(this.rootIsolateToken);

  final RootIsolateToken rootIsolateToken;

  @override
  TypedSendPort<void> buildTypedSendPort(SendPort sendPort) => TypedSendPort<void>(sendPort);

  @override
  void handleMessageInIsolate(GraphQLIsolate isolate, TypedSendPort<void> responsePort) {
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    responsePort.send(null);
  }
}
