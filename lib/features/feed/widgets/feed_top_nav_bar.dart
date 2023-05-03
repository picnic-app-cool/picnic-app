import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/top_navigation/feed_items_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class FeedTopNavBar extends StatelessWidget {
  const FeedTopNavBar({
    Key? key,
    required this.onTapProfile,
    required this.onTapSearch,
    required this.onTabChanged,
    required this.onTapCirclesSideMenu,
    required this.selectedTab,
    required this.tabs,
    required this.overlayTheme,
    required this.onTapSeeMore,
    required this.showSeeMoreButton,
    required this.profileImageUrl,
  }) : super(key: key);

  final VoidCallback onTapSearch;
  final VoidCallback onTapProfile;
  final VoidCallback onTapCirclesSideMenu;
  final Function(Feed) onTabChanged;
  final VoidCallback onTapSeeMore;
  final Feed selectedTab;
  final List<Feed> tabs;
  final PostOverlayTheme overlayTheme;
  final bool showSeeMoreButton;
  final ImageUrl profileImageUrl;

  static const _avatarSize = 24.0;

  @override
  Widget build(BuildContext context) {
    const spacing16 = 16.0;
    final colors = PicnicTheme.of(context).colors;
    final Color iconColor;
    final Color tabsColor;
    switch (overlayTheme) {
      case PostOverlayTheme.dark:
        tabsColor = colors.blackAndWhite.shade800;
        iconColor = colors.darkBlue.shade600;
        break;
      case PostOverlayTheme.light:
        tabsColor = colors.blackAndWhite.shade100;
        iconColor = colors.blackAndWhite.shade100;
        break;
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: PicnicIconButton(
            icon: Assets.images.sideMenuIcon.path,
            iconColor: iconColor,
            style: PicnicIconButtonStyle.minimal,
            onTap: onTapCirclesSideMenu,
          ),
        ),
        Expanded(
          child: FeedItemsBar(
            tabs: tabs,
            selectedFeed: selectedTab,
            titleColor: tabsColor,
            onTabChanged: onTabChanged,
            onSeeMoreTap: onTapSeeMore,
            showSeeMoreButton: showSeeMoreButton,
          ),
        ),
        const Gap(spacing16),
        PicnicIconButton(
          icon: Assets.images.search.path,
          iconColor: iconColor,
          style: PicnicIconButtonStyle.minimal,
          onTap: onTapSearch,
        ),
        const Gap(spacing16),
        PicnicAvatar(
          imageSource: profileImageUrl.isAsset
              ? PicnicImageSource.asset(profileImageUrl, fit: BoxFit.cover)
              : PicnicImageSource.url(profileImageUrl, fit: BoxFit.cover),
          size: _avatarSize,
          boxFit: PicnicAvatarChildBoxFit.cover,
          onTap: onTapProfile,
        ),
        const Gap(spacing16),
      ],
    );
  }
}
