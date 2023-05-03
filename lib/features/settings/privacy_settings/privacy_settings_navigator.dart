import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_navigator.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_page.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/vertical_action_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class PrivacySettingsNavigator
    with
        VerticalActionBottomSheetRoute,
        DeleteAccountConfirmationRoute,
        DeleteAccountRoute,
        AllowAccessContactConfirmationRoute,
        CloseRoute,
        ErrorBottomSheetRoute {
  PrivacySettingsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PrivacySettingsRoute {
  Future<void> openPrivacySettings(PrivacySettingsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PrivacySettingsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin DeleteAccountConfirmationRoute {
  void showDeleteAccountConfirmation({
    required VoidCallback onTapDelete,
    required VoidCallback onTapClose,
  }) =>
      showPicnicBottomSheet(
        ConfirmationBottomSheet(
          title: appLocalizations.deleteAccountAction,
          message: appLocalizations.deleteAccountMessage,
          primaryAction: ConfirmationAction(
            roundedButton: true,
            title: appLocalizations.deleteAction,
            action: onTapDelete,
          ),
          secondaryAction: ConfirmationAction.negative(
            action: () {
              appNavigator.close();
              onTapClose();
            },
          ),
        ),
      );

  AppNavigator get appNavigator;
}

mixin AllowAccessContactConfirmationRoute {
  Future<bool?> showAllowAccessContactConfirmation({
    required VoidCallback onTakeToSettings,
    required VoidCallback onClose,
  }) =>
      showPicnicBottomSheet<bool?>(
        ConfirmationBottomSheet(
          title: appLocalizations.allowPicnicAccessContactsTitle,
          message: appLocalizations.allowPicnicAccessContactsMessage,
          primaryAction: ConfirmationAction(
            title: appLocalizations.takeMeToSettingsAction,
            roundedButton: true,
            isPositive: true,
            action: () {
              onTakeToSettings();

              // close the bottom sheet
              appNavigator.close();

              //close the privacy settings page
              appNavigator.close();
            },
          ),
          secondaryAction: ConfirmationAction(
            action: onClose,
            title: appLocalizations.cancelAction,
          ),
        ),
      );

  AppNavigator get appNavigator;
}
