import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/main/main_initial_params.dart' as picnic_app;
import 'package:picnic_app/features/main/main_page.dart' as picnic_app;
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_desktop_app/dependency_injection/app_component.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/features/main/main_page.dart';

class MainNavigator with NoRoutes {
  MainNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

//ignore_for_file: unused-code, unused-files
mixin MainRoute {
  Future<void> openMain(MainInitialParams initialParams) async {
    final page = featureFlagsStore.featureFlags[FeatureFlagType.useDesktopUiOnDesktop]
        ? getIt<MainPage>(param1: initialParams)
        : getIt<picnic_app.MainPage>(param1: const picnic_app.MainInitialParams());

    return appNavigator.push(
      materialRoute(page),
    );
  }

  AppNavigator get appNavigator;

  FeatureFlagsStore get featureFlagsStore;
}
