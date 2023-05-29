import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class InviteFriendsBottomSheetNavigator with CloseRoute, ErrorBottomSheetRoute, ShareRoute {
  InviteFriendsBottomSheetNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin InviteFriendsBottomSheetRoute {
  Future<void> showVerticalActionBottomSheet(InviteFriendsBottomSheetInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<InviteFriendsBottomSheetPage>(param1: initialParams),
      useRootNavigator: true,
    );
  }

  AppNavigator get appNavigator;
}
