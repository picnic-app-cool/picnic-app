import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';

class UnreadCounterBadge extends StatelessWidget {
  const UnreadCounterBadge({
    Key? key,
    required this.count,
    this.color,
    this.size,
  }) : super(key: key);
  final int count;
  final Color? color;
  final double? size;

  static const double _badgeSize = 14;
  static const double _badgeFontSize = 12;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    const badgePadding = EdgeInsets.all(2);

    final badgeTextStyle = theme.styles.body10.copyWith(
      color: Colors.white,
      height: 1.0,
      fontSize: _badgeFontSize,
    );

    return PicnicBadge(
      badgeSize: size ?? _badgeSize,
      count: count,
      badgeBackgroundColor: color ?? colors.pink,
      badgeTextColor: Colors.white,
      badgePadding: badgePadding,
      badgeStyle: badgeTextStyle,
    );
  }
}
