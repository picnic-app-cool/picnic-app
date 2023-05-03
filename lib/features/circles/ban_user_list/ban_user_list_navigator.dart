import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_page.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class BanUserListNavigator with CloseRoute, BanUserRoute, CloseRoute, ErrorBottomSheetRoute, ProfileRoute {
  BanUserListNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin BanUserListRoute {
  Future<void> openBanUserList(BanUserListInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<BanUserListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
