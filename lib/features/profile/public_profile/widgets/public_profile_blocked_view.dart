import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PublicProfileBlockedView extends StatelessWidget {
  const PublicProfileBlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return PicnicDialog(
      image: PicnicAvatar(
        backgroundColor:
            PicnicTheme.of(context).colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
        imageSource: PicnicImageSource.emoji(
          Constants.noEntryEmoji,
          style: const TextStyle(
            fontSize: Constants.onboardingEmojiSize,
          ),
        ),
      ),
      title: appLocalizations.noContent,
      description: appLocalizations.nothingToShow,
      showShadow: false,
    );
  }
}
