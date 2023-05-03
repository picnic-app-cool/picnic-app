import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast.dart';

mixin ReachedListEndRoute {
  Future<void> showReachedListEndToast() => showPicnicToast(
        context: context,
        builder: (context) => PicnicToast(
          text: appLocalizations.reachedListEnd,
          icon: PicnicImageSource.emoji(
            Constants.emojiSeeNoEvilMonkey,
            style: const TextStyle(
              fontSize: Constants.emojiSize,
            ),
          ),
        ),
      );

  BuildContext get context;
}
