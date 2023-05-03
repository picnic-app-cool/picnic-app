import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class BlockedListNavigator with ProfileRoute, ErrorBottomSheetRoute {
  BlockedListNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin BlockedListRoute {
  void openBlockedList(BlockedListInitialParams initialParams) {
    appNavigator.push(
      materialRoute(getIt<BlockedListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
