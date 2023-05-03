import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class NoPostsCard extends StatelessWidget {
  const NoPostsCard({
    super.key,
    required this.onTapCreatePost,
  });

  final VoidCallback onTapCreatePost;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final borderRadius = BorderRadius.circular(24);
    const avatarSize = 88.0;
    const avatarColor = Color(0xFFECF8EB);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: blackAndWhite.shade300,
        ),
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PicnicAvatar(
            imageSource: PicnicImageSource.emoji(
              Constants.emojiSeeNoEvilMonkey,
              style: const TextStyle(fontSize: 42),
            ),
            backgroundColor: avatarColor,
            size: avatarSize,
          ),
          const Gap(20),
          Text(
            appLocalizations.noPostsTitle,
            style: theme.styles.title30,
          ),
          const Gap(8),
          Text(
            appLocalizations.noPostsMessage,
            style: theme.styles.caption20.copyWith(
              color: blackAndWhite.shade600,
            ),
          ),
          const Gap(20),
          PicnicButton(
            title: appLocalizations.postToCircleAction,
            onTap: onTapCreatePost,
          ),
        ],
      ),
    );
  }
}
