import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast.dart';

mixin SaveAttachmentsRoute {
  Future<void> showSavingAttachmentsToast({required int count, required Future<void> delay}) => showPicnicToast(
        context: context,
        builder: (context) => PicnicToast(
          text: appLocalizations.savingAttachmentsToast(count),
          showLoading: true,
        ),
        delay: delay,
      );

  Future<void> showAttachmentsSavedToast({required int count}) => showPicnicToast(
        context: context,
        builder: (context) => PicnicToast(
          text: appLocalizations.attachmentsSavedToast(count),
          icon: PicnicImageSource.emoji(
            Constants.partyPopperEmoji,
            style: const TextStyle(
              fontSize: Constants.emojiSize,
            ),
          ),
        ),
      );

  BuildContext get context;
}
