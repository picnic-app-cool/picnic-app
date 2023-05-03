import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';

class InviteFriendsNavigator with ShareRoute, ErrorBottomSheetRoute {
  InviteFriendsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin InviteFriendsRoute {
  Future<void> openInviteFriends(InviteFriendsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<InviteFriendsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
