import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_page.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/widgets/save_changes_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/image_editor_route.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class EditCircleNavigator
    with
        AvatarSelectionRoute,
        ErrorBottomSheetRoute,
        CloseWithResultRoute<Circle>,
        CloseRoute,
        DiscardCircleInfoChangesRoute,
        ChangeCircleAvatarRoute,
        ImagePickerRoute,
        ImageEditorRoute {
  EditCircleNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin EditCircleRoute {
  Future<Circle?> openEditCircle(EditCircleInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<EditCirclePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin DiscardCircleInfoChangesRoute {
  Future<bool?> showDiscardCircleInfoChangesRoute({
    VoidCallback? onTapSave,
  }) =>
      showPicnicBottomSheet<bool?>(
        ConfirmationBottomSheet(
          title: appLocalizations.unsavedCircleInfoTitle,
          message: appLocalizations.unsavedCircleInfoSubTitle,
          primaryAction: ConfirmationAction(
            title: appLocalizations.unSavedInfoSecondAction,
            roundedButton: true,
            action: () {
              //this is to close the bottom sheet
              appNavigator.close();
              //this is to confirm navigation to previous page TODO(GS-5291): create method https://picnic-app.atlassian.net/browse/GS-5291
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
