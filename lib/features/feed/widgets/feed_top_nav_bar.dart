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
    this.unreadNotificationsCount = 0,
  }) : super(key: key);

  final VoidCallback onTapNotifications;
  final VoidCallback onTapCirclesSideMenu;
  final Function(Feed) onTabChanged;
  final Feed selectedTab;
  final List<Feed> tabs;
  final PostOverlayTheme overlayTheme;
  final int unreadNotificationsCount;

  static const _backgroundOpacity = 0.12;
  static const _iconSize = 28.0;
  static const _iconContainerSize = 100.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final Color iconColor;
    final Color tabsColor;
    final Color tabsBackgroundColor;
    switch (overlayTheme) {
      case PostOverlayTheme.dark:
        tabsColor = colors.blackAndWhite.shade800;
        tabsBackgroundColor = colors.darkBlue.shade300;
        iconColor = colors.darkBlue.shade600;
        break;
      case PostOverlayTheme.light:
        tabsColor = colors.blackAndWhite.shade100;
        tabsBackgroundColor = colors.blackAndWhite.shade100.withOpacity(_backgroundOpacity);
        iconColor = colors.blackAndWhite.shade100;
        break;
    }
    return Row(
      children: [
        const Gap(16),
        PicnicIconButton(
          size: _iconContainerSize,
          iconSize: _iconSize,
          icon: Assets.images.sideMenuIcon.path,
          iconColor: iconColor,
          style: PicnicIconButtonStyle.minimal,
          onTap: onTapCirclesSideMenu,
        ),
        const Gap(8),
        Expanded(
          child: FeedItemsBar(
            tabs: tabs,
            selectedFeed: selectedTab,
            titleColor: tabsColor,
            backgroundColor: tabsBackgroundColor,
            onTabChanged: onTabChanged,
          ),
        ),
        const Gap(8),
        PicnicContainerIconButton(
          iconPath: Assets.images.notificationBell.path,
          badgeValue: unreadNotificationsCount,
          onTap: onTapNotifications,
          iconTintColor: iconColor,
        ),
        const Gap(16),
      ],
    );
  }
}
