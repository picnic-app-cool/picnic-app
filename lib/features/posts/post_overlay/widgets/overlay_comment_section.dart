import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/achievement_badge.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_comment_action.dart';
import 'package:picnic_app/ui/widgets/picnic_dynamic_author.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class OverlayCommentSection extends StatelessWidget {
  const OverlayCommentSection({
    super.key,
    required this.comments,
    required this.onTapCommentAuthor,
    required this.onTapLikeUnlike,
    required this.onTapComment,
    required this.onTapReply,
    required this.onLongTapComment,
    required this.onDoubleTapComment,
  });

  final List<CommentPreview> comments;
  final void Function(Id) onTapCommentAuthor;
  final void Function(CommentPreview) onTapLikeUnlike;
  final void Function(CommentPreview) onTapReply;
  final void Function(CommentPreview) onTapComment;
  final void Function(CommentPreview) onLongTapComment;
  final void Function(CommentPreview) onDoubleTapComment;

  static const _commentAvatarSize = 30.0;
  static const _opacityValueWhite = 0.7;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final tealColor = colors.teal;
    final whiteColor = colors.blackAndWhite.shade100;
    final whiteWithOpacity = whiteColor.withOpacity(_opacityValueWhite);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 4),
        shrinkWrap: true,
        children: comments
            .map(
              (it) => InkWell(
                onTap: () => onTapComment(it),
                onLongPress: () => onLongTapComment(it),
                onDoubleTap: () => onDoubleTapComment(it),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PicnicDynamicAuthor(
                          avatar: PicnicAvatar(
                            size: _commentAvatarSize,
                            backgroundColor: tealColor,
                            borderColor: Colors.white,
                            imageSource: PicnicImageSource.url(it.author.profileImageUrl, fit: BoxFit.cover),
                            boxFit: PicnicAvatarChildBoxFit.cover,
                            onTap: () => onTapCommentAuthor(it.author.id),
                          ),
                          onUsernameTap: () => onTapCommentAuthor(it.author.id),
                          username: it.author.username.formattedUsername,
                          titleColor: whiteWithOpacity,
                          usernameBadge: it.author.isVerified
                              ? const AchievementBadge(type: AchievementBadgeType.verifiedBlue)
                              : null,
                          commentColor: whiteColor,
                          comment: it.text,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PicnicCommentAction(
                            count: it.repliesCount,
                            onTap: () => onTapReply(it),
                            iconPath: Assets.images.undo.path,
                            iconColor: whiteColor,
                            overlay: true,
                          ),
                          const Gap(16),
                          PicnicCommentAction(
                            count: it.likesCount,
                            onTap: () => onTapLikeUnlike(it),
                            iconPath: it.isLiked ? Assets.images.heartBold.path : Assets.images.favorite.path,
                            iconColor: it.isLiked ? null : whiteColor,
                            overlay: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
