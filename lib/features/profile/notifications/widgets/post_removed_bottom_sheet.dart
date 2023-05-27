import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostRemovedBottomSheet extends StatelessWidget {
  const PostRemovedBottomSheet({
    super.key,
  });

  static const _paddingSize = 20.0;
  static const _avatarSize = 40.0;
  static const _postRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(_paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                appLocalizations.removedPostTitle,
                style: styles.subtitle40,
              ),
            ),
            const Gap(20),
            PicnicListItem(
              leftGap: 0,
              trailingGap: 0,
              leading: PicnicAvatar(
                boxFit: PicnicAvatarChildBoxFit.cover,
                size: _avatarSize,
                backgroundColor: theme.colors.lightBlue.shade100,
                imageSource: EmojiPicnicImageSource('👻'),
              ),
              // TODO(GS-4764): Get the circle name dynamically.
              title: appLocalizations.postRemovedTitle('[circle]'),
              subTitle: appLocalizations.postRemovedSubtitle,
              subTitleStyle: styles.caption20.copyWith(color: colors.blackAndWhite.shade600),
              titleStyle: styles.subtitle20,
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(_postRadius),
                child: PicnicImage(
                  source: EmojiPicnicImageSource('🤞'),
                ),
              ),
            ),
            const Gap(20),
            RichText(
              text: TextSpan(
                text: '${appLocalizations.removedPostBecause}  ',
                style: styles.body20,
                children: [
                  TextSpan(
                    text: appLocalizations.removedPostBecauseGraphic,
                  ),
                  TextSpan(
                    text: appLocalizations.pleaseReferTo,
                  ),
                  TextSpan(
                    text: ' ${appLocalizations.terms} ',
                    style: styles.body20.copyWith(color: colors.blue),
                  ),
                  TextSpan(
                    text: appLocalizations.forMoreDetails,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
