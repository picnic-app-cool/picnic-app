import 'package:flutter/widgets.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin ConfirmationBottomSheetRoute {
  //ignore: long-parameter-list
  Future<T?> showConfirmationBottomSheet<T>({
    required String title,
    required String message,
    required ConfirmationAction primaryAction,
    required ConfirmationAction secondaryAction,
  }) async {
    return showPicnicBottomSheet<T>(
      ConfirmationBottomSheet(
        title: title,
        message: message,
        primaryAction: primaryAction,
        secondaryAction: secondaryAction,
      ),
    );
  }
}

class ConfirmationAction {
  ConfirmationAction({
    required this.title,
    required this.action,
    this.roundedButton = false,
    this.isPositive = false,
  });

  ConfirmationAction.negative({
    required this.action,
    String? title,
    this.roundedButton = false,
    this.isPositive = false,
  }) : title = title ?? appLocalizations.noAction;

  final String title;
  final VoidCallback action;
  final bool roundedButton;
  final bool isPositive;
}
