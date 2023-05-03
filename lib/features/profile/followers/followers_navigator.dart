import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/followers/followers_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class FollowersNavigator with ErrorBottomSheetRoute, ProfileRoute, CloseWithResultRoute<bool> {
  FollowersNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin FollowersRoute {
  Future<bool?> openFollowers(FollowersInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<FollowersPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
