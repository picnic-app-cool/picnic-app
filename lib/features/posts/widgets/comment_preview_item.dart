import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/achievement_badge.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_comment_action.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_like_heart_column.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CommentPreviewItem extends StatelessWidget {
  const CommentPreviewItem({
    Key? key,
    required this.comment,
    this.onTapLikeUnlike,
    this.onTapReply,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapCommentAuthor,
    this.overlay = false,
    this.isDense = false,
  }) : super(key: key);

  final bool isDense;
  final CommentPreview comment;
  final VoidCallback? onTapLikeUnlike;
  final VoidCallback? onTapReply;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onTapCommentAuthor;
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final tealColor = theme.colors.teal;
    final textStyleCaption10 = theme.styles.caption10;
    final textStyleBody0 = theme.styles.body0.copyWith(
      color: blackAndWhite.shade900.withOpacity(0.4),
    );

    final topAvatarSize = isDense ? 24.0 : 40.0;

    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: PicnicListItem(
        title: comment.author.username.formattedUsername,
        titleBadge: comment.author.isVerified ? const AchievementBadge(type: AchievementBadgeType.verifiedRed) : null,
        subTitle: comment.text,
        titleStyle: textStyleBody0,
        subTitleStyle: textStyleCaption10,
        subtitleMaxLines: isDense ? 1 : null,
        subtitleTextOverflow: isDense ? TextOverflow.ellipsis : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PicnicCommentAction(
              count: comment.repliesCount,
              onTap: onTapReply,
              iconPath: Assets.images.undo.path,
              iconColor: overlay ? blackAndWhite.shade100 : null,
            ),
            const Gap(Constants.defaultPadding),
            PicnicLikeHeartColumn(
              likesCount: comment.likesCount,
              onTapLikeHeart: onTapLikeUnlike,
              liked: comment.isLiked,
            ),
          ],
        ),
        leading: PicnicAvatar(
          size: topAvatarSize,
          followButtonBackgroundColor: theme.colors.blue,
          followButtonForegroundColor: blackAndWhite.shade100,
          backgroundColor: tealColor,
          borderColor: theme.colors.indigo,
          boxFit: PicnicAvatarChildBoxFit.cover,
          imageSource: PicnicImageSource.url(comment.author.profileImageUrl, fit: BoxFit.cover),
          onTap: onTapCommentAuthor,
        ),
      ),
    );
  }
}
