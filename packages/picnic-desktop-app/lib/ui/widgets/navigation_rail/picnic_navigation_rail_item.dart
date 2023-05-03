import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';
import 'package:picnic_desktop_app/ui/widgets/navigation_rail/picnic_nav_item.dart';

class PicnicNavigationRailItem extends StatelessWidget {
  const PicnicNavigationRailItem({
    super.key,
    required this.item,
    required this.isActive,
    this.badgeCount,
    required this.onTap,
  });

  final PicnicNavItem item;
  final bool isActive;
  final int? badgeCount;
  final Function(PicnicNavItemId) onTap;

  static const double _iconSize = 28;
  static const double _activeIconWidth = 25;
  static const double _activeIconHeight = 10;
  static const double _badgeSize = 18;
  static const double _badgeRightDistance = 18;
  static const double _badgeBottomDistance = 42;
  static const double _badgeFontSize = 12;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final iconColor = colors.blackAndWhite.shade900;
    final badgeExists = badgeCount != null;

    return InkResponse(
      onTap: () => onTap(item.id),
      child: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    AssetImage(
                      isActive ? item.activeIcon : item.icon,
                    ),
                    size: _iconSize,
                    color: iconColor,
                  ),
                  const Gap(4),
                  if (item.label != null)
                    Text(
                      item.label!,
                      style: theme.styles.caption10.copyWith(
                        color: iconColor,
                        fontWeight: isActive ? FontWeight.w500 : FontWeight.w300,
                      ),
                    ),
                ],
              ),
            ),
            if (isActive) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Image.asset(
                    Assets.images.bottomNavigationActive.path,
                    width: _activeIconWidth,
                    height: _activeIconHeight,
                    color: iconColor,
                  ),
                ),
              ),
            ],
            if (badgeExists) ...[
              Positioned(
                bottom: _badgeBottomDistance,
                right: _badgeRightDistance,
                child: PicnicBadge(
                  badgePadding: const EdgeInsets.only(bottom: 2),
                  badgeSize: _badgeSize,
                  badgeStyle: theme.styles.body10.copyWith(
                    color: colors.blackAndWhite.shade100,
                    fontWeight: FontWeight.w400,
                    fontSize: _badgeFontSize,
                  ),
                  count: badgeCount!,
                  badgeBackgroundColor: colors.pink,
                  badgeTextColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
