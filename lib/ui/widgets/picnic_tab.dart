import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';

class PicnicTab extends StatelessWidget {
  const PicnicTab({
    Key? key,
    this.iconPath,
    required this.title,
    this.onTap,
    this.badgeCount,
    this.isActive = true,
    this.bottomPadding = 0,
  }) : super(key: key);

  final String? iconPath;
  final String title;
  final int? badgeCount;
  final bool isActive;
  final VoidCallback? onTap;
  final double bottomPadding;

  static const double _iconSize = 24;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final darkBlue = theme.colors.darkBlue;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null)
              ImageIcon(
                AssetImage(iconPath!),
                size: _iconSize,
                color: theme.colors.activeTabColor,
              ),
            if (iconPath != null) const Gap(8),
            Text(
              title,
              style: theme.styles.link15.copyWith(
                color: isActive ? darkBlue.shade900 : darkBlue,
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
