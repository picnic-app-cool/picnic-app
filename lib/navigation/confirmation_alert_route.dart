import 'package:flutter/widgets.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_confirmation_alert.dart';

mixin ConfirmationAlertRoute {
  //ignore: long-parameter-list
  void showConfirmationAlert({
    required String title,
    required String description,
    required String buttonLabel,
    required String iconEmoji,
    required VoidCallback? onTap,
  }) {
    appNavigator.push(
      fadeInRoute(
        PicnicConfirmationAlert(
          title: title,
          description: description,
          buttonLabel: buttonLabel,
          iconEmoji: iconEmoji,
          onTap: onTap,
        ),
        opaque: false,
      ),
    );
  }

  AppNavigator get appNavigator;
}
