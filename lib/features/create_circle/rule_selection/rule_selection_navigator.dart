import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_page.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class RuleSelectionNavigator with AboutElectionsRoute, ErrorBottomSheetRoute {
  RuleSelectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleRuleSelectionRoute {
  Future<void> openCircleRuleSelection(RuleSelectionInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<RuleSelectionPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
