import 'package:picnic_app/localization/app_localizations_utils.dart';

/// A failure with the title and message that could be easly displayed as a dialog or snackbar
class DisplayableFailure {
  DisplayableFailure({
    required this.title,
    required this.message,
  });

  DisplayableFailure.commonError([String? message])
      : title = appLocalizations.commonErrorTitle,
        // TODO move this to strings file
        message = message ?? appLocalizations.commonErrorMessage;

  String title;
  String message;
}

abstract class HasDisplayableFailure {
  DisplayableFailure displayableFailure();
}
