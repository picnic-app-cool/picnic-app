import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_page.dart';
import 'package:picnic_app/features/profile/edit_profile/widgets/save_changes_button.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/image_editor_route.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class EditProfileNavigator
    with
        CloseRoute,
        ImagePickerRoute,
        ErrorBottomSheetRoute,
        PrivateProfileRoute,
        CloseWithResultRoute<bool>,
        ConfirmationBottomSheetRoute,
        DiscardProfileInfoChangesRoute,
        ImageEditorRoute {
  EditProfileNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin EditProfileRoute {
  Future<bool?> openEditProfile(EditProfileInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(
        getIt<EditProfilePage>(param1: initialParams),
      ),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}

mixin DiscardProfileInfoChangesRoute {
  Future<bool?> showDiscardProfileInfoChangesRoute({
    VoidCallback? onTapSave,
    VoidCallback? onTapDiscard,
  }) =>
      showPicnicBottomSheet<bool?>(
        ConfirmationBottomSheet(
          title: appLocalizations.unSavedProfileInfoTitle,
          message: appLocalizations.unSavedProfileInfoMessage,
          primaryAction: ConfirmationAction(
            title: appLocalizations.unSavedInfoSecondAction,
            roundedButton: true,
            action: () {
              onTapDiscard?.call();

              // this is to navigate back to previous page TODO(GS-5291): create method https://picnic-app.atlassian.net/browse/GS-5291
              appNavigator.closeWithResult(false);
            },
          ),
          contentWidget: SaveChangesButton(
            onTapSave: onTapSave,
          ),
          secondaryAction: ConfirmationAction(
            action: () => onTapDiscard?.call(),
            title: appLocalizations.cancelAction,
          ),
        ),
      );

  AppNavigator get appNavigator;
}
