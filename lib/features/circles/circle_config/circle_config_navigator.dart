import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_page.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';

class CircleConfigNavigator
    with
        ErrorBottomSheetRoute,
        CircleCreationRulesRoute,
        CircleCreationSuccessRoute,
        CloseRoute,
        AboutElectionsRoute,
        CloseWithResultRoute<Circle?>,
        FeatureDisabledBottomSheetRoute {
  CircleConfigNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleConfigRoute {
  Future<Circle?> openCircleConfig(CircleConfigInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleConfigPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
