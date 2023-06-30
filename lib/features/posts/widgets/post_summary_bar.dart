import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/achievement_badge.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_rectangle_avatar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_author_details.dart';
import 'package:picnic_app/utils/defer_pointer/defer_pointer.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_app/utils/extensions/time_ago_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostSummaryBar extends StatelessWidget {
  const PostSummaryBar({
    Key? key,
    required this.author,
    required this.post,
    required this.onToggleFollow,
    required this.onTapTag,
    required this.onTapAuthor,
    this.onTapCircle,
    this.onTapJoinCircle,
    this.displayTag = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.showTagPrefixIcon = true,
    this.showTagBackground = false,
    this.isDense = false,
    this.overlayTheme,
    this.showTimestamp = false,
    this.showFollowButton = false,
  }) : super(key: key);

  final BasicPublicProfile author;
  final Post post;
  final VoidCallback? onToggleFollow;
  final VoidCallback? onTapTag;
  final VoidCallback? onTapAuthor;
  final VoidCallback? onTapJoinCircle;
  final VoidCallback? onTapCircle;
  final bool displayTag;
  final EdgeInsets padding;
  final bool showTagPrefixIcon;
  final bool showTagBackground;
  final bool isDense;
  final PostOverlayTheme? overlayTheme;
  final bool showTimestamp;
  final bool showFollowButton;

  static const _avatarSize = 38.0;
  static const _avatarSizeDense = 38.0;
  static const _emojiSize = 18.0;
  static const _emojiSizeDense = 18.0;

  double get avatarSize => isDense ? _avatarSizeDense : _avatarSize;

  double get emojiSize => isDense ? _emojiSizeDense : _emojiSize;

  @override
  Widget build(BuildContext context) {
    final overlayTheme = this.overlayTheme ?? post.overlayTheme;
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final whiteColor = colors.blackAndWhite.shade100.withOpacity(0.9);
    final blackColor = colors.blackAndWhite.shade900;

    final postDetailsColor = overlayTheme == PostOverlayTheme.dark ? colors.blackAndWhite.shade600 : whiteColor;

    final titleBadge = author.isVerified
        ? const AchievementBadge(
            type: AchievementBadgeType.verifiedRed,
          )
        : null;

    final circle = post.circle;
    final circleEmoji = circle.emoji;
    final circleImage = circle.imageFile;
    final deferredLink = DeferredPointerHandlerLink();
    final postTimeCreationDate = post.createdAt?.timeElapsedWithoutAgo();

    return Padding(
      padding: padding,
      child: DeferredPointerHandler(
        link: deferredLink,
        child: PicnicBarWithAuthorDetails(
          avatarPadding: const EdgeInsets.only(right: 4.0),
          showShadowForLightColor: true,
          avatar: PicnicCircleRectangleAvatar(
            bgColor: PicnicColors.ultraPaleGrey,
            borderColor: overlayTheme == PostOverlayTheme.light ? null : colors.darkBlue.shade300,
            onTap: onTapCircle,
            avatarSize: avatarSize,
            emojiSize: emojiSize,
            image: circleImage,
            emoji: circleEmoji,
            isVerified: circle.isVerified,
          ),
          postDetails: null,
          titleColor: overlayTheme == PostOverlayTheme.dark ? blackColor : whiteColor,
          circleName: post.circle.name,
          authorUsername: author.username.formattedUsername,
          date: showTimestamp ? postTimeCreationDate : null,
          titlePadding: const EdgeInsets.only(bottom: 4.0),
          authorVerifiedBadge: titleBadge,
          onAuthorUsernameTap: onTapAuthor,
          viewsCount: post.contentStats.impressions,
          subtitleColor: postDetailsColor,
          iFollow: post.author.iFollow,
          iJoined: post.circle.iJoined,
          joinTextColor: overlayTheme == PostOverlayTheme.dark ? colors.darkBlue.shade700 : whiteColor,
          onTapFollow: showFollowButton ? onToggleFollow : null,
          onTapJoinCircle: onTapJoinCircle,
          onCircleNameTap: onTapCircle,
        ),
      ),
    );
  }
}
