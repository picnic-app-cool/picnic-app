import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_container_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicContainerIconButton extends StatelessWidget {
  const PicnicContainerIconButton({
    Key? key,
    required this.iconPath,
    this.onTap,
    this.buttonColor,
    this.height,
    this.width,
    this.iconTintColor,
    this.radius,
    this.padding,
    this.backdropFilter,
    this.selected = false,
    this.badgeValue,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String iconPath;

  final Color? buttonColor;

  final double? height;
  final double? width;

  final Color? iconTintColor;

  final double? radius;
  final double? padding;

  final ImageFilter? backdropFilter;

  final bool selected;

  static const double buttonSize = 48;

  final int? badgeValue;

  @override
  Widget build(BuildContext context) {
    final primaryColor = buttonColor ?? Colors.transparent;
    final secondaryColor = iconTintColor ?? PicnicTheme.of(context).colors.darkBlue.shade600;

    return PicnicContainerButton(
      buttonColor: selected ? secondaryColor : primaryColor,
      height: height ?? buttonSize,
      width: width ?? buttonSize,
      radius: radius,
      padding: padding,
      onTap: onTap,
      backdropFilter: backdropFilter,
      badgeValue: badgeValue,
      child: Image.asset(
        iconPath,
        color: selected ? primaryColor : secondaryColor,
      ),
    );
  }
}
