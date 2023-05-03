import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class FeatureDisabledBottomSheet extends StatelessWidget {
  const FeatureDisabledBottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.onTapClose,
  }) : super(key: key);

  final String title;
  final String description;
  final VoidCallback onTapClose;

  @override
  Widget build(BuildContext context) {
    const avatarSize = 88.0;
    final theme = PicnicTheme.of(context);
    final avatarColor = theme.colors.blackAndWhite.shade200;
    final styles = theme.styles;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: PicnicAvatar(
              imageSource: PicnicImageSource.emoji(
                Constants.emojiSeeNoEvilMonkey,
                style: const TextStyle(fontSize: 42),
              ),
              backgroundColor: avatarColor,
              size: avatarSize,
            ),
          ),
          const Gap(20),
          Text(
            title,
            style: styles.title30,
          ),
          const Gap(20),
          Text(
            description,
            style: styles.body20,
          ),
          const Gap(20),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTapClose,
            ),
          ),
        ],
      ),
    );
  }
}
