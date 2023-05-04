import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_page.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class CircleMemberSettingsNavigator
    with
        CloseWithResultRoute<bool>,
        ConfirmationBottomSheetRoute,
        ErrorBottomSheetRoute,
        UserRolesRoute,
        SingleChatRoute,
        FxEffectRoute,
        ProfileRoute {
  CircleMemberSettingsNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin CircleMemberSettingsRoute {
  Future<bool?> openCircleMemberSettings(CircleMemberSettingsInitialParams initialParams) =>
      showPicnicBottomSheet(getIt<CircleMemberSettingsPage>(param1: initialParams));

  AppNavigator get appNavigator;
}
