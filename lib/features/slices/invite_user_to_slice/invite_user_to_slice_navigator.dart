import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_initial_params.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class InviteUserToSliceNavigator with CloseRoute, ErrorBottomSheetRoute {
  InviteUserToSliceNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin InviteUserToSliceRoute {
  Future<void> openInviteUserList(InviteUserToSliceInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<InviteUserToSlicePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
