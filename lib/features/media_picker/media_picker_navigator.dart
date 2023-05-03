import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/get_media_route.dart';

class MediaPickerNavigator with ErrorBottomSheetRoute, GetMediaRoute {
  MediaPickerNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  Future<void> showFileSizeTooBigError({required int maxAllowedSize}) async {
    return showError(
      DisplayableFailure(
        title: appLocalizations.fileSizeTooBigErrorTitle,
        message: appLocalizations.fileSizeTooBigErrorMessage(maxAllowedSize),
      ),
    );
  }
}
