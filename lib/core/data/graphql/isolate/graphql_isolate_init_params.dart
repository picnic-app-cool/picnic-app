import 'dart:isolate';

import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_dependencies_configurator.dart';
import 'package:picnic_app/picnic_app_init_params.dart';

class GraphQLIsolateInitParams {
  GraphQLIsolateInitParams(
    this.sendPort,
    this.hivePath,
    this.appInitParams,
    this.dependenciesConfigurator,
  );

  final SendPort sendPort;
  final String hivePath;
  final PicnicAppInitParams appInitParams;
  final GraphQLIsolateDependenciesConfigurator dependenciesConfigurator;
}
