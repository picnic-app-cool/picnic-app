import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class RolesListNavigator with CloseRoute, CircleRoleRoute, ErrorBottomSheetRoute {
  RolesListNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin RolesListRoute {
  Future<void> openRolesList(RolesListInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<RolesListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
