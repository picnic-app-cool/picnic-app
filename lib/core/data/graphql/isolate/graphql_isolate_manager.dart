import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:picnic_app/core/data/graphql/graphql_unauthenticated_failure_handler.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_dependencies_configurator.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_init_params.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_isolate_message.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/graphql_token_update_message.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/init_message.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/listen_auth_token_updates_message.dart';
import 'package:picnic_app/core/data/graphql/isolate/messages/listen_to_unauthenticated_message.dart';
import 'package:picnic_app/core/data/hive/hive_path_provider.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/picnic_app_init_params.dart';

class GraphQLIsolateManager {
  late Isolate _isolate;
  late SendPort _sendPort;

  StreamSubscription<AuthToken>? _tokenSubscription;

  Future<void> startGraphQLIsolate(
    AuthTokenRepository autoTokenRepository,
    GraphQLUnauthenticatedFailureHandler unauthenticatedFailureHandler,
    HivePathProvider hivePathProvider,
  ) async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      GraphQLIsolate.isolateEntryPoint,
      GraphQLIsolateInitParams(
        receivePort.sendPort,
        await hivePathProvider.path,
        getIt<PicnicAppInitParams>(),
        getIt<GraphQLIsolateDependenciesConfigurator>(),
      ),
    );
    _sendPort = await receivePort.first as SendPort;
    //this makes sure that we initialize back channels that allow communicating with isolates under the hood
    await sendMessageToIsolate(InitMessage(RootIsolateToken.instance!)).first;

    await initAuthTokenLinkBetweenIsolates(autoTokenRepository);
    await initUnauthenticatedHandlerLinkBetweenIsolates(unauthenticatedFailureHandler);
  }

  void dispose() {
    _tokenSubscription?.cancel();
    _isolate.kill(priority: Isolate.immediate);
  }

  Stream<R> sendMessageToIsolate<R>(GraphQLIsolateMessage<R> message) {
    final responsePort = ReceivePort();
    _sendPort.send(IsolateMessage(message, responsePort.sendPort));
    return responsePort.map((event) => event as R);
  }

  /// listens to token updates on main repo and sends them to GraphQL isolate.
  /// Establishes a two-way communication between main isolate and the repository one.
  /// Should be called from within main isolate
  Future<void> initAuthTokenLinkBetweenIsolates(
    AuthTokenRepository mainIsolateRepo,
  ) async {
    Stream<void> _sendTokenToGraphQL(
      GraphQLIsolateManager isolateManager,
      AuthToken token,
    ) =>
        isolateManager.sendMessageToIsolate(GraphQLTokenUpdateMessage(token));

    await mainIsolateRepo.getAuthToken().doOn(
          success: (token) => _sendTokenToGraphQL(this, token),
        );
    _tokenSubscription = mainIsolateRepo.listenAuthToken().listen((newToken) {
      _sendTokenToGraphQL(this, newToken);
    });
    sendMessageToIsolate(ListenAuthTokenUpdatesMessage()).listen((event) {
      mainIsolateRepo.saveAuthToken(event);
    });
  }

  Future<void> initUnauthenticatedHandlerLinkBetweenIsolates(
    GraphQLUnauthenticatedFailureHandler unauthenticatedFailureHandler,
  ) async {
    await unauthenticatedFailureHandler.prepareContextEntry();

    sendMessageToIsolate(const ListenToUnauthenticatedMessage()).listen((message) async {
      await unauthenticatedFailureHandler.handle(tokenHashCode: message.tokenHashCode);
      message.sendPort.send(null);
    });
  }
}

class IsolateMessage<R> {
  IsolateMessage(this.message, this.sendPort);

  final GraphQLIsolateMessage<R> message;
  final SendPort sendPort;
}
