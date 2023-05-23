import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';
import 'package:picnic_app/ui/widgets/swipe_detector.dart';
import 'package:picnic_app/ui/widgets/unread_counter_badge.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// Bottom navigation component
/// [activeItem] indicates what item is currently active
/// [showDecoration] adds background and shadow for the component
class PicnicBottomNavigation extends StatelessWidget {
  const PicnicBottomNavigation({
    Key? key,
    required this.activeItem,
    required this.overlayTheme,
    this.showDecoration = true,
    required this.onTap,
    required this.items,
    required this.onTabSwiped,
    required this.userImageUrl,
    this.unreadChatsCount = 0,
  }) : super(key: key);

  final PostOverlayTheme overlayTheme;
  final PicnicNavItem activeItem;
  final bool showDecoration;
  final Function(PicnicNavItem) onTap;
  final List<PicnicNavItem> items;
  final Function(PicnicNavItem) onTabSwiped;
  final int unreadChatsCount;
  final String? userImageUrl;

  static const double tabsPadding = 6.0;
  static const double barHeight = 64;
  static const double _defaultIconSize = 28;
  static const double _addPostIconHeight = 36 + tabsPadding;
  static const double _addPostIconWidth = 52 + tabsPadding;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final blackAndWhite = theme.colors.blackAndWhite;

    return SwipeDetector(
      onSwipeLeft: _onSwipeLeft,
      onSwipeRight: _onSwipeRight,
      child: Material(
        color: showDecoration
            ? blackAndWhite.shade100
            : (overlayTheme == PostOverlayTheme.light ? blackAndWhite.shade900 : blackAndWhite.shade100),
        child: SizedBox(
          height: barHeight + bottomPadding,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.map((it) {
                return SizedBox(
                  width: _getTabWidth(it, activeItem == it),
                  child: _PicnicBottomNavigationItem(
                    item: it,
                    isActive: activeItem == it,
                    overlayTheme: overlayTheme,
                    onTap: onTap,
                    unreadChatsCount: unreadChatsCount,
                    iconWidth: it == PicnicNavItem.add ? _addPostIconWidth : _defaultIconSize,
                    iconHeight: it == PicnicNavItem.add ? _addPostIconHeight : _defaultIconSize,
                    userImageUrl: userImageUrl,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  double _getTabWidth(PicnicNavItem navItem, bool isActive) {
    if (navItem == PicnicNavItem.add) {
      return _addPostIconWidth;
    } else {
      if (navItem == PicnicNavItem.profile && isActive) {
        return _defaultIconSize + tabsPadding;
      }
      return _defaultIconSize + tabsPadding;
    }
  }

  void _onSwipeLeft() {
    final nextTab = activeItem.nextTab(items);
    if (nextTab != null) {
      onTabSwiped(nextTab);
    }
  }

  void _onSwipeRight() {
    final previousTab = activeItem.previousTab(items);
    if (previousTab != null) {
      onTabSwiped(previousTab);
    }
  }
}

class _PicnicBottomNavigationItem extends StatelessWidget {
  const _PicnicBottomNavigationItem({
    Key? key,
    required this.item,
    required this.isActive,
    required this.overlayTheme,
    required this.onTap,
    required this.unreadChatsCount,
    required this.iconWidth,
    required this.iconHeight,
    required this.userImageUrl,
  }) : super(key: key);

  final PicnicNavItem item;
  final bool isActive;
  final PostOverlayTheme overlayTheme;
  final Function(PicnicNavItem) onTap;
  final int unreadChatsCount;
  final double iconWidth;
  final double iconHeight;
  final String? userImageUrl;

  static const double _activeIconWidth = 6;
  static const double _activeIconHeight = 6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final iconColor = item == PicnicNavItem.feed ? _getColor(colors) : null;
    final showUnreadMessagesBadge = unreadChatsCount > 0 && item == PicnicNavItem.chat;

    return InkResponse(
      onTap: () => onTap(item),
      child: AnimatedSwitcher(
        duration: const ShortDuration(),
        child: SizedBox(
          key: ValueKey(item.value),
          child: Stack(
            children: [
              Center(
                child: Stack(
                  children: [
                    if (item == PicnicNavItem.profile && userImageUrl != null && userImageUrl!.isNotEmpty)
                      _UserProfileImageTab(
                        userImageUrl: userImageUrl!,
                        isActive: isActive,
                        iconHeight: iconHeight,
                        iconWidth: iconWidth,
                      )
                    else
                      Image.asset(
                        isActive ? item.getActiveIcon(overlayTheme) : item.getIcon(overlayTheme),
                        width: iconWidth,
                        height: iconHeight,
                        color: iconColor,
                      ),
                    if (showUnreadMessagesBadge)
                      Positioned(
                        right: 0,
                        child: UnreadCounterBadge(count: unreadChatsCount),
                      ),
                  ],
                ),
              ),
              if (showUnreadMessagesBadge)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      width: _activeIconWidth,
                      height: _activeIconHeight,
                      decoration: BoxDecoration(
                        color: colors.pink,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getColor(PicnicColors colors) {
    switch (overlayTheme) {
      case PostOverlayTheme.dark:
        return colors.blackAndWhite.shade900;
      case PostOverlayTheme.light:
        return colors.blackAndWhite.shade100;
    }
  }
}

class _UserProfileImageTab extends StatelessWidget {
  const _UserProfileImageTab({
    required this.userImageUrl,
    required this.isActive,
    required this.iconHeight,
    required this.iconWidth,
  });

  final String userImageUrl;
  final bool isActive;
  final double iconHeight;
  final double iconWidth;

  static const radius = 50.0;
  static const borderSize = 2.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;

    return Stack(
      children: [
        if (isActive)
          Center(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: iconWidth + PicnicBottomNavigation.tabsPadding,
                    height: iconHeight + PicnicBottomNavigation.tabsPadding,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.blackAndWhite.shade900,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: iconWidth + (PicnicBottomNavigation.tabsPadding - borderSize),
                    height: iconHeight + (PicnicBottomNavigation.tabsPadding - borderSize),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.blackAndWhite.shade100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.network(
              userImageUrl,
              width: iconWidth,
              height: iconHeight,
            ),
          ),
        ),
      ],
    );
  }
}
