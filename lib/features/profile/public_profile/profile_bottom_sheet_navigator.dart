//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_page.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ProfileBottomSheetNavigator
    with
        NoRoutes,
        CloseRoute,
        FollowersRoute,
        ErrorBottomSheetRoute,
        SingleChatRoute,
        WebViewRoute,
        CloseWithResultRoute<bool>,
        ConfirmationBottomSheetRoute,
        SnackBarRoute,
        FxEffectRoute,
        PublicProfileRoute {
  ProfileBottomSheetNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ProfileBottomSheetRoute {
  Future<void> openProfileBottomSheet(ProfileBottomSheetInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<ProfileBottomSheetPage>(param1: initialParams),
    );
  }

  AppNavigator get appNavigator;
}
