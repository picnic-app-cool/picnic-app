import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class EditRulesNavigator with CloseWithResultRoute<String>, ErrorBottomSheetRoute {
  EditRulesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin EditRulesRoute {
  Future<String?> openEditRules(EditRulesInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<EditRulesPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
