import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';

///abstraction around messages sent from main isolate to GraphQL isolate
abstract class GraphQLIsolateMessage<R> {
  /// method called from within the isolate to handle the received payload
  void handleMessageInIsolate(GraphQLIsolate isolate, TypedSendPort<R> responsePort);

  /// builds TypedSendPort with proper generic type. this is needed to overcome dart limitation of infering generic
  /// types when casting dynamic to GraphQLIsolateMessage.
  TypedSendPort<R> buildTypedSendPort(SendPort sendPort);
}

class TypedSendPort<T> {
  TypedSendPort(this._sendPort);

  final SendPort _sendPort;

  void send(T message) {
    _sendPort.send(message);
  }
}
