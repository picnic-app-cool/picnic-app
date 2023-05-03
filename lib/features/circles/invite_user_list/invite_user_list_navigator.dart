import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class InviteUserListNavigator with CloseRoute, ErrorBottomSheetRoute {
  InviteUserListNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin InviteUserListRoute {
  Future<void> openInviteUserList(InviteUserListInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<InviteUserListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
