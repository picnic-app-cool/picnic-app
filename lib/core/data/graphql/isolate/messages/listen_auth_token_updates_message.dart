import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class ListenAuthTokenUpdatesMessage implements GraphQLIsolateMessage<AuthToken> {
  @override
  void handleMessageInIsolate(
    GraphQLIsolate isolate,
    TypedSendPort<AuthToken> responsePort,
  ) {
    isolate.tokenUpdatesRepository.listenAuthToken().listen((event) {
      responsePort.send(event);
    });
  }

  @override
  TypedSendPort<AuthToken> buildTypedSendPort(SendPort sendPort) => TypedSendPort(sendPort);
}
