import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/resources/assets.gen.dart';
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
    this.unreadChatsCount = 0,
  }) : super(key: key);

  final PostOverlayTheme overlayTheme;
  final PicnicNavItem activeItem;
  final bool showDecoration;
  final Function(PicnicNavItem) onTap;
  final List<PicnicNavItem> items;
  final Function(PicnicNavItem) onTabSwiped;
  final int unreadChatsCount;

  static const double barHeight = 64;
  static const double _barBorderRadius = 32;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    const radius = BorderRadius.only(
      topLeft: Radius.circular(_barBorderRadius),
      topRight: Radius.circular(_barBorderRadius),
    );
    return SwipeDetector(
      onSwipeLeft: _onSwipeLeft,
      onSwipeRight: _onSwipeRight,
      child: Material(
        color: showDecoration ? theme.colors.blackAndWhite.shade100 : Colors.transparent,
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: showDecoration ? Border.all(color: PicnicColors.lightGrey) : null,
          ),
          height: barHeight + bottomPadding,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.map((it) {
                if (it == PicnicNavItem.add) {
                  return Flexible(
                    child: _PicnicBottomNavigationAddItem(
                      item: PicnicNavItem.add,
                      onTap: onTap,
                    ),
                  );
                }

                return Flexible(
                  child: _PicnicBottomNavigationItem(
                    item: it,
                    isActive: activeItem == it,
                    overlayTheme: overlayTheme,
                    onTap: onTap,
                    unreadChatsCount: unreadChatsCount,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
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
  }) : super(key: key);

  final PicnicNavItem item;
  final bool isActive;
  final PostOverlayTheme overlayTheme;
  final Function(PicnicNavItem) onTap;
  final int unreadChatsCount;

  static const double _iconSize = 28;
  static const double _activeIconWidth = 25;
  static const double _activeIconHeight = 10;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final iconColor = _getColor(colors);
    final showBadge = unreadChatsCount > 0 && item == PicnicNavItem.chat;

    return InkResponse(
      onTap: () => onTap(item),
      child: AnimatedSwitcher(
        duration: const ShortDuration(),
        child: SizedBox(
          key: ValueKey(iconColor),
          child: Stack(
            children: [
              Center(
                child: Stack(
                  children: [
                    ImageIcon(
                      AssetImage(
                        isActive ? item.getActiveIcon() : item.getIcon(),
                      ),
                      size: _iconSize,
                      color: iconColor,
                    ),
                    if (showBadge)
                      Positioned(
                        right: 0,
                        child: UnreadCounterBadge(count: unreadChatsCount),
                      ),
                  ],
                ),
              ),
              if (isActive)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Image.asset(
                      Assets.images.bottomNavigationActive.path,
                      width: _activeIconWidth,
                      height: _activeIconHeight,
                      color: iconColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(PicnicColors colors) {
    switch (overlayTheme) {
      case PostOverlayTheme.dark:
        return colors.blackAndWhite.shade900;
      case PostOverlayTheme.light:
        return colors.blackAndWhite.shade100;
    }
  }
}

class _PicnicBottomNavigationAddItem extends StatelessWidget {
  const _PicnicBottomNavigationAddItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final PicnicNavItem item;
  final Function(PicnicNavItem) onTap;

  static const double _buttonWidth = 48;
  static const double _buttonHeight = 40;
  static const double _buttonRadius = 10;

  @override
  Widget build(BuildContext context) {
    final bwColors = PicnicTheme.of(context).colors.blackAndWhite;

    return InkResponse(
      onTap: () => onTap(item),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: _buttonWidth,
        height: _buttonHeight,
        decoration: BoxDecoration(
          color: bwColors.shade100,
          borderRadius: BorderRadius.circular(_buttonRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFF1013F),
              offset: Offset(0, -3),
            ),
            BoxShadow(
              color: Color(0xFF41DA01),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          item.getIcon(),
          fit: BoxFit.cover,
          color: bwColors.shade900,
        ),
      ),
    );
  }
}
