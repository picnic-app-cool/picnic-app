import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicIconButton extends StatelessWidget {
  const PicnicIconButton({
    super.key,
    this.onTap,
    this.iconColor,
    this.color,
    this.size = _defaultSize,
    this.iconSize = _defaultIconSize,
    this.style = PicnicIconButtonStyle.filled,
    required this.icon,
  });

  final VoidCallback? onTap;
  final String icon;
  final Color? iconColor;
  final Color? color;
  final PicnicIconButtonStyle style;
  final double size;
  final double iconSize;

  static const double _defaultSize = 50;
  static const double _defaultIconSize = 22;
  static const double _defaultOpacity = 0.3;
  static const double _defaultSplashRadius = 22;
  static const double _defaultBlurRadius = 8;

  @override
  Widget build(BuildContext context) {
    final filledStyle = style == PicnicIconButtonStyle.filled;
    final minimal = style == PicnicIconButtonStyle.minimal;
    final whiteColor = PicnicTheme.of(context).colors.blackAndWhite.shade100;
    final opacityColor = color ?? whiteColor.withOpacity(_defaultOpacity);
    final simpleIcon = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Image.asset(
        key: ValueKey('$icon$iconColor'),
        icon,
        color: iconColor ?? whiteColor,
        height: iconSize,
        fit: BoxFit.contain,
      ),
    );
    final child = Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: filledStyle ? color : opacityColor,
      ),
      child: IconButton(
        onPressed: onTap,
        highlightColor: opacityColor,
        splashRadius: _defaultSplashRadius,
        icon: simpleIcon,
      ),
    );

    if (minimal) {
      return InkWell(
        onTap: onTap,
        child: simpleIcon,
      );
    }
    if (filledStyle) {
      return ClipOval(
        child: child,
      );
    }

    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _defaultBlurRadius,
          sigmaY: _defaultBlurRadius,
        ),
        child: child,
      ),
    );
  }
}

enum PicnicIconButtonStyle {
  filled,
  blurred,
  minimal,
}
