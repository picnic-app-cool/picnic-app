import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast.dart';

mixin MessageCopiedRoute {
  Future<void> showMessageCopiedToast() => showPicnicToast(
        context: context,
        builder: (context) => PicnicToast(
          text: appLocalizations.messageCopiedToClipboard,
          icon: PicnicImageSource.emoji(
            Constants.emojiClipboard,
            style: const TextStyle(
              fontSize: Constants.emojiSize,
            ),
          ),
        ),
      );

  BuildContext get context;
}
