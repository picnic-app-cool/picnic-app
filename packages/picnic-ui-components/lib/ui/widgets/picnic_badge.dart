import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicBadge extends StatelessWidget {
  const PicnicBadge({
    super.key,
    required this.count,
    this.badgeBackgroundColor,
    this.badgeRadius,
    this.badgeSize,
    this.badgeTextColor,
    this.badgeStyle,
    this.badgePadding = _badgePadding,
  });

  final int count;

  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;
  final TextStyle? badgeStyle;
  final double? badgeRadius;
  final double? badgeSize;
  final EdgeInsets? badgePadding;

  static const double _badgeSize = 20;
  static const double _badgeRadius = 10;
  static const EdgeInsets _badgePadding = EdgeInsets.only(
    top: 2,
    left: 2,
    right: 2,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final badgeText = count > 9 ? '9+' : count.toString();

    return Container(
      width: badgeSize ?? _badgeSize,
      height: badgeSize ?? _badgeSize,
      padding: _badgePadding,
      decoration: BoxDecoration(
        color: badgeBackgroundColor ?? theme.colors.pink.shade500,
        borderRadius: BorderRadius.circular(badgeRadius ?? _badgeRadius),
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            badgeText,
            style: badgeStyle ??
                theme.styles.body10.copyWith(
                  color: badgeTextColor ?? theme.colors.blackAndWhite.shade100,
                  height: 1.0,
                ),
          ),
        ),
      ),
    );
  }
}
