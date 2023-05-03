import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_navigator.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_page.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class BannedUsersNavigator with ProfileRoute, BanUserListRoute, ErrorBottomSheetRoute {
  BannedUsersNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin BannedUsersRoute {
  Future<void> openBannedUsers(BannedUsersInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<BannedUsersPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
