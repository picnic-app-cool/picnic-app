import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class UserRolesNavigator with CloseRoute, ErrorBottomSheetRoute, FeatureDisabledBottomSheetRoute {
  UserRolesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin UserRolesRoute {
  Future<void> openUserRoles(UserRolesInitialParams initialParams) =>
      showPicnicBottomSheet(getIt<UserRolesPage>(param1: initialParams));

  AppNavigator get appNavigator;
}
