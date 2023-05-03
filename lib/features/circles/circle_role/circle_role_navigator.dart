import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_page.dart';
import 'package:picnic_app/features/profile/edit_profile/widgets/save_changes_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/color_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class CircleRoleNavigator
    with AvatarSelectionRoute, ErrorBottomSheetRoute, CloseRoute, DiscardCircleRoleChangesRoute, ColorBottomSheetRoute {
  CircleRoleNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleRoleRoute {
  Future<void> openCircleRole(CircleRoleInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleRolePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin DiscardCircleRoleChangesRoute {
  Future<bool?> showDiscardCircleInfoChangesRoute({
    VoidCallback? onTapSave,
  }) =>
      showPicnicBottomSheet<bool?>(
        ConfirmationBottomSheet(
          title: appLocalizations.unsavedRoleChanges,
          message: appLocalizations.unsavedRoleChangesDetails,
          primaryAction: ConfirmationAction(
            title: appLocalizations.unSavedInfoSecondAction,
            roundedButton: true,
            action: () {
              //this is to close the bottom sheet
              appNavigator.close();

              //this is to navigate back
              appNavigator.close();
            },
          ),
          contentWidget: SaveChangesButton(
            onTapSave: onTapSave,
          ),
          secondaryAction: ConfirmationAction(
            action: () => appNavigator.close(),
            title: appLocalizations.cancelAction,
          ),
        ),
      );

  AppNavigator get appNavigator;
}
