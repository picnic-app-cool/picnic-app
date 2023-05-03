import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

/// message received from Main isolate that contains updated token
class GraphQLTokenUpdateMessage implements GraphQLIsolateMessage<void> {
  GraphQLTokenUpdateMessage(this.token);

  final AuthToken token;

  @override
  void handleMessageInIsolate(GraphQLIsolate isolate, TypedSendPort<void> responsePort) {
    isolate.tokenUpdatesRepository.saveAuthToken(token);
  }

  @override
  TypedSendPort<void> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
