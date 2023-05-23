import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/feed_items_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class FeedTopNavBar extends StatelessWidget {
  const FeedTopNavBar({
    Key? key,
    required this.onTapNotifications,
    required this.onTabChanged,
    required this.onTapCirclesSideMenu,
    required this.selectedTab,
    required this.tabs,
    required this.overlayTheme,
    required this.onTapSeeMore,
    required this.showSeeMoreButton,
    this.unreadNotificationsCount = 0,
  }) : super(key: key);

  final VoidCallback onTapNotifications;
  final VoidCallback onTapCirclesSideMenu;
  final Function(Feed) onTabChanged;
  final VoidCallback onTapSeeMore;
  final Feed selectedTab;
  final List<Feed> tabs;
  final PostOverlayTheme overlayTheme;
  final bool showSeeMoreButton;
  final int unreadNotificationsCount;

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
        PicnicContainerIconButton(
          iconPath: Assets.images.notificationBell.path,
          badgeValue: unreadNotificationsCount,
          onTap: onTapNotifications,
          iconTintColor: iconColor,
        ),
        const Gap(spacing16),
      ],
    );
  }
}
