import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicBlurredPage extends StatelessWidget {
  const PicnicBlurredPage({
    Key? key,
    required this.page,
    this.blurIntensity = _defaultBlurIntensity,
    this.opacity = _defaultBackgroundOpacity,
    this.bgColor,
    this.isDismissible = true,
  }) : super(key: key);

  final Widget page;
  final double blurIntensity;
  final double opacity;
  final Color? bgColor;
  final bool isDismissible;

  static const _defaultBackgroundOpacity = 0.5;
  static const _defaultBlurIntensity = 10.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final backgroundColor = bgColor ?? theme.colors.lightBlue[200]?.withOpacity(opacity);
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurIntensity,
                sigmaY: blurIntensity,
              ),
              child: Container(),
            ),
          ),
        ),
        GestureDetector(
          onTap: isDismissible ? () => Navigator.of(context).pop() : null,
          child: Container(
            color: backgroundColor,
            child: page,
          ),
        ),
      ],
    );
  }
}
