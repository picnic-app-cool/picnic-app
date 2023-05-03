import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast.dart';

mixin BackgroundCallsRoute {
  Future<void> showBackgroundCallsLimitReachedToast() => showPicnicToast(
        context: context,
        builder: (context) => PicnicToast(
          text: appLocalizations.backgroundCallsLimitReached,
          icon: PicnicImageSource.emoji(
            Constants.emojiSeeNoEvilMonkey,
            style: const TextStyle(
              fontSize: Constants.emojiSize,
            ),
          ),
          shake: true,
        ),
      );

  Future<void> showBackgroundCallFailedToast() => showPicnicToast(
        context: context,
        builder: (context) => PicnicToast(
          text: appLocalizations.backgroundCallFailed,
          icon: PicnicImageSource.emoji(
            Constants.sadEmoji,
            style: const TextStyle(
              fontSize: Constants.emojiSize,
            ),
          ),
          shake: true,
        ),
      );

  BuildContext get context;
}
