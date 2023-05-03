import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_page.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class CircleCreationRulesNavigator with CircleRuleSelectionRoute {
  CircleCreationRulesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleCreationRulesRoute {
  Future<void> openCircleCreationRules(CircleCreationRulesInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleCreationRulesPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
