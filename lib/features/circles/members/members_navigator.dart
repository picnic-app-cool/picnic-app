import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/members/members_initial_params.dart';
import 'package:picnic_app/features/circles/members/members_page.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/invite_users_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';

class MembersNavigator
    with
        MembersRoute,
        ErrorBottomSheetRoute,
        ProfileRoute,
        InviteUsersRoute,
        CloseRoute,
        SnackBarRoute,
        InviteUserListRoute,
        CircleRoleRoute,
        UserRolesRoute {
  MembersNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin MembersRoute {
  Future<void> openMembersPage(MembersInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<MembersPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
