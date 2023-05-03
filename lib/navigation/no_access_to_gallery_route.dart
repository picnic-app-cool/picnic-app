import 'package:app_settings/app_settings.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin NoAccessToGalleryRoute {
  AppNavigator get appNavigator;

  Future<void> showNoGalleryAccess() => showPicnicBottomSheet(
        ConfirmationBottomSheet(
          topImagePath: Assets.images.noAccessToGallery.path,
          title: appLocalizations.noAccesstoGalleryTitle,
          message: appLocalizations.noAccesstoGalleryMessage,
          primaryAction: ConfirmationAction(
            title: appLocalizations.goToSettings,
            action: () {
              AppSettings.openAppSettings();
              appNavigator.close();
            },
          ),
        ),
      );
}
