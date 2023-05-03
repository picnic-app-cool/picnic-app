import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicFloatingButton extends StatelessWidget {
  const PicnicFloatingButton({
    Key? key,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;

  static const _iconSize = 38.0;
  static const _buttonSize = 70.0;
  static const _blurRadius = 30.0;
  static const _shadowOpacity = 0.07;

  @override
  Widget build(BuildContext context) {
    final themeColors = PicnicTheme.of(context).colors;

    final iconColor = this.iconColor ?? Colors.white;
    final icon = this.icon ?? Icons.add;

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: _blurRadius,
            color: themeColors.blackAndWhite.shade900.withOpacity(_shadowOpacity),
          ),
        ],
      ),
      child: FloatingActionButton(
        elevation: 0,
        onPressed: onTap,
        backgroundColor: backgroundColor,
        child: Icon(
          icon,
          size: _iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
