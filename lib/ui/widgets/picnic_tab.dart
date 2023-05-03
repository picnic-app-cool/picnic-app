import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';

class PicnicTab extends StatelessWidget {
  const PicnicTab({
    Key? key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.badgeCount,
    this.isActive = true,
  }) : super(key: key);

  final String iconPath;
  final String title;
  final int? badgeCount;
  final bool isActive;
  final VoidCallback? onTap;

  static const double _inactiveOpacity = 0.4;
  static const double _activeOpacity = 1;
  static const double _iconSize = 24;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: isActive ? _activeOpacity : _inactiveOpacity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(
              AssetImage(iconPath),
              size: _iconSize,
              color: theme.colors.activeTabColor,
            ),
            const Gap(8),
            Text(
              title,
              style: theme.styles.body30.copyWith(
                color: const Color(0xFF39487C),
              ),
            ),
            if (badgeCount != null) ...[
              const Gap(6),
              PicnicBadge(count: badgeCount ?? 0),
            ],
          ],
        ),
      ),
    );
  }
}
