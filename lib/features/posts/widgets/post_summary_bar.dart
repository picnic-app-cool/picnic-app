import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/achievement_badge.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_tag_avatar.dart';
import 'package:picnic_app/utils/defer_pointer/defer_pointer.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_app/utils/extensions/time_ago_formatting.dart';
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
    this.showViewCountAtEnd = false,
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
  final bool showViewCountAtEnd;

  static const _avatarSize = 50.0;
  static const _suffixIconSize = 14.0;
  static const _avatarSizeDense = 40.0;
  static const _lightTagOpacity = 0.2;
  static const _darkTagOpacity = 0.07;
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
    final greenColor = colors.green.shade500;

    Color? tagBackgroundColor;

    if (showTagBackground) {
      tagBackgroundColor = overlayTheme == PostOverlayTheme.dark ? blackColor : whiteColor;
    }

    final viewsCountColor =
        overlayTheme == PostOverlayTheme.dark ? blackColor.withOpacity(0.5) : whiteColor.withOpacity(0.7);

    final textStyle = theme.styles.body10.copyWith(
      color: overlayTheme == PostOverlayTheme.dark ? blackColor : whiteColor,
      shadows: [
        if (overlayTheme == PostOverlayTheme.light) PostOverlayPage.textShadow(context),
      ],
    );

    final titleBadge = author.isVerified
        ? AchievementBadge(
            type: overlayTheme == PostOverlayTheme.dark
                ? AchievementBadgeType.verifiedBlue
                : AchievementBadgeType.verifiedWhite,
          )
        : null;

    final circle = post.circle;
    final circleEmoji = circle.emoji;
    final circleImage = circle.imageFile;
    final deferredLink = DeferredPointerHandlerLink();

    return Padding(
      padding: padding,
      child: DeferredPointerHandler(
        link: deferredLink,
        child: PicnicBarWithTagAvatar(
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
            followButtonBackgroundColor: overlayTheme == PostOverlayTheme.dark ? greenColor : whiteColor,
            followButtonForegroundColor: overlayTheme == PostOverlayTheme.dark ? whiteColor : greenColor,
          ),
          tag: displayTag
              ? PicnicTag(
                  opacity: overlayTheme == PostOverlayTheme.dark ? _darkTagOpacity : _lightTagOpacity,
                  title: post.circle.name,
                  titleTextStyle: textStyle,
                  prefixIcon: showTagPrefixIcon
                      ? circleImage.isNotEmpty
                          ? PicnicCircleAvatar(
                              emoji: circleEmoji,
                              image: circleImage,
                              avatarSize: _circleAvatarSize,
                              emojiSize: _emojiSize,
                            )
                          : Text(
                              circleEmoji,
                              style: textStyle,
                            )
                      : null,
                  suffixIcon: post.circle.iJoined
                      ? null
                      : Image.asset(
                          Assets.images.add.path,
                          height: _suffixIconSize,
                          color: overlayTheme == PostOverlayTheme.dark ? blackColor : whiteColor,
                        ),
                  backgroundColor: tagBackgroundColor,
                  onTap: onTapTag,
                  onSuffixTap: onTapJoinCircle,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                )
              : null,
          showViewCountAtEnd: showViewCountAtEnd,
          titleColor: overlayTheme == PostOverlayTheme.dark ? blackColor : whiteColor,
          title: author.username.formattedUsername,
          date: showTimestamp ? post.createdAt?.timeElapsed() : null,
          titleBadge: titleBadge,
          titlePadding: const EdgeInsets.only(bottom: 4.0),
          onTitleTap: onTapAuthor,
          viewsCount: post.viewsCount,
          viewsCountColor: viewsCountColor,
        ),
      ),
    );
  }
}
