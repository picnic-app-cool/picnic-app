import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class FeatureFlagsNavigator with NoRoutes, ErrorBottomSheetRoute {
  FeatureFlagsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin FeatureFlagsRoute {
  Future<void> openFeatureFlags(FeatureFlagsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<FeatureFlagsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
