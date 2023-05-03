import 'dart:async';
import 'dart:isolate';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_executor.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_init_params.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_manager.dart';
import 'package:picnic_app/core/data/graphql/isolate/isolate_auth_token_repository.dart';
import 'package:picnic_app/core/data/hive/adapters/hive_json_adapter.dart';
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

class GraphQLIsolate {
  late GraphQLExecutor gqlExecutor;
  late IsolateAuthTokenRepository tokenUpdatesRepository;
  late SessionInvalidatedListenersContainer sessionInvalidatedListenersContainer;

  static Future<void> isolateEntryPoint(GraphQLIsolateInitParams initParams) async {
    final receivePort = ReceivePort();
    initParams.sendPort.send(receivePort.sendPort);
    final isolate = GraphQLIsolate();
    await isolate.init(initParams);
    receivePort.listen((isolateMsg) async {
      if (isolateMsg is IsolateMessage) {
        isolateMsg.message.handleMessageInIsolate(
          isolate,
          isolateMsg.message.buildTypedSendPort(
            isolateMsg.sendPort,
          ),
        );
      } else {
        debugLog("Received unknown message to graphQL isolate: $isolateMsg");
      }
    });
  }

  Future<void> init(GraphQLIsolateInitParams params) async {
    await params.dependenciesConfigurator.configure(params.appInitParams);
    getIt.registerFactory(
      () => GraphQLExecutor(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
    await getIt.unregister<AuthTokenRepository>();
    tokenUpdatesRepository = IsolateAuthTokenRepository();
    getIt.registerFactory<AuthTokenRepository>(() => tokenUpdatesRepository);
    Hive.init(params.hivePath);
    Hive.registerAdapter(HiveJsonAdapter(1));

    gqlExecutor = getIt<GraphQLExecutor>();
    sessionInvalidatedListenersContainer = getIt();
  }
}
