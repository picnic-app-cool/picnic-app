import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostingDisabledCard extends StatelessWidget {
  const PostingDisabledCard({
    super.key,
    required this.postingType,
    required this.circleName,
  });

  final PostType postingType;
  final String circleName;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final borderRadius = BorderRadius.circular(24);
    const avatarSize = 88.0;
    final avatarColor = blackAndWhite.shade200;
    final caption20style = theme.styles.caption20;
    final subtitleStyle = caption20style.copyWith(color: blackAndWhite.shade600);

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
            appLocalizations.postingDisabledTitle(postingType.value.toLowerCase()),
            style: theme.styles.subtitle40,
          ),
          const Gap(8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "${appLocalizations.featureDisabledByMods} ", style: subtitleStyle),
                TextSpan(text: circleName, style: caption20style.copyWith(color: colors.blue.shade600)),
                TextSpan(text: " ${appLocalizations.circle}", style: subtitleStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
