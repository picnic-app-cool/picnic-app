import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/picnic_app_init_params.dart';

class GraphQLIsolateDependenciesConfigurator {
  Future<void> configure(PicnicAppInitParams appInitParams) async {
    configureDependencies(appInitParams);
  }
}
