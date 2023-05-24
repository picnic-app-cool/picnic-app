import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/achievement_badge.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_author_details.dart';
import 'package:picnic_app/utils/defer_pointer/defer_pointer.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_app/utils/extensions/time_ago_formatting.dart';
import 'package:picnic_app/utils/number_formatter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostSummaryBar extends StatelessWidget {
  const PostSummaryBar({
    Key? key,
    required this.author,
    required this.post,
    required this.onToggleFollow,
    required this.onTapTag,
    required this.onTapAuthor,
    this.onTapJoinCircle,
    this.displayTag = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.showTagPrefixIcon = true,
    this.showTagBackground = false,
    this.isDense = false,
    this.overlayTheme,
    this.showTimestamp = false,
  }) : super(key: key);

  final BasicPublicProfile author;
  final Post post;
  final VoidCallback? onToggleFollow;
  final VoidCallback? onTapTag;
  final VoidCallback? onTapAuthor;
  final VoidCallback? onTapJoinCircle;
  final bool displayTag;
  final EdgeInsets padding;
  final bool showTagPrefixIcon;
  final bool showTagBackground;
  final bool isDense;
  final PostOverlayTheme? overlayTheme;
  final bool showTimestamp;

  static const _avatarSize = 50.0;
  static const _avatarSizeDense = 40.0;
  static const _emojiSize = 12.0;
  static const _circleAvatarSize = 24.0;

  double get avatarSize => isDense ? _avatarSizeDense : _avatarSize;

  @override
  Widget build(BuildContext context) {
    final overlayTheme = this.overlayTheme ?? post.overlayTheme;
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final whiteColor = colors.blackAndWhite.shade100;
    final blackColor = colors.blackAndWhite.shade900;
    final blueColor = colors.blue;

    final postDetailsColor = overlayTheme == PostOverlayTheme.dark ? colors.blackAndWhite.shade600 : whiteColor;

    final textStyle = theme.styles.body0.copyWith(
      color: postDetailsColor,
      shadows: [
        if (overlayTheme == PostOverlayTheme.light) PostOverlayPage.textShadow(context),
      ],
    );

    final titleBadge = author.isVerified
        ? AchievementBadge(
            type: overlayTheme == PostOverlayTheme.dark
                ? AchievementBadgeType.verifiedRed
                : AchievementBadgeType.verifiedWhite,
          )
        : null;

    final circle = post.circle;
    final circleEmoji = circle.emoji;
    final circleImage = circle.imageFile;
    final deferredLink = DeferredPointerHandlerLink();
    final postTimeCreationDate = post.createdAt?.timeElapsed();
    final dateToDisplay = showTimestamp && post.createdAt != null ? '$postTimeCreationDate • ' : '';

    return Padding(
      padding: padding,
      child: DeferredPointerHandler(
        link: deferredLink,
        child: PicnicBarWithAuthorDetails(
          avatarPadding: const EdgeInsets.only(right: 8.0),
          showShadowForLightColor: true,
          avatar: PicnicAvatar(
            deferredLink: deferredLink,
            size: avatarSize,
            backgroundColor: colors.blue.shade100,
            borderColor: Colors.white,
            iFollow: author.iFollow,
            onToggleFollow: onToggleFollow,
            onTap: onTapAuthor,
            placeholder: () => DefaultAvatar.user(),
            imageSource: PicnicImageSource.url(
              ImageUrl(author.profileImageUrl.url),
              fit: BoxFit.cover,
            ),
            boxFit: PicnicAvatarChildBoxFit.cover,
            followButtonBackgroundColor: overlayTheme == PostOverlayTheme.dark ? blueColor : whiteColor,
            followButtonForegroundColor: overlayTheme == PostOverlayTheme.dark ? whiteColor : blueColor,
          ),
          postDetails: displayTag
              ? Row(
                  children: [
                    const Gap(2),
                    Image.asset(
                      Assets.images.downRightArrow.path,
                      color: postDetailsColor,
                    ),
                    const Gap(4),
                    if (circleImage.isNotEmpty)
                      PicnicCircleAvatar(
                        emoji: circleEmoji,
                        image: circleImage,
                        avatarSize: _circleAvatarSize,
                        emojiSize: _emojiSize,
                      )
                    else
                      Text(
                        circleEmoji,
                        style: textStyle,
                      ),
                    const Gap(4),
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapTag,
                        child: Text(
                          post.circle.name,
                          style: textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const Gap(16),
                    Text(
                      dateToDisplay + appLocalizations.viewsCount(formatNumber(post.contentStats.impressions)),
                      style: textStyle,
                    ),
                  ],
                )
              : null,
          titleColor: overlayTheme == PostOverlayTheme.dark ? blackColor : whiteColor,
          title: author.username.formattedUsername,
          date: showTimestamp ? postTimeCreationDate : null,
          titleBadge: titleBadge,
          titlePadding: const EdgeInsets.only(bottom: 4.0),
          onTitleTap: onTapAuthor,
          viewsCount: post.contentStats.impressions,
          subtitleColor: postDetailsColor,
        ),
      ),
    );
  }
}
