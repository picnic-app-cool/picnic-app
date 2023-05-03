import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class PicnicCameraSecondaryButton extends StatelessWidget {
  const PicnicCameraSecondaryButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.color,
  });

  final VoidCallback onTap;
  final String icon;
  final Color? color;

  static const _buttonSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return PicnicIconButton(
      icon: icon,
      color: color ?? PicnicTheme.of(context).colors.blackAndWhite.shade900,
      style: PicnicIconButtonStyle.blurred,
      onTap: onTap,
      size: _buttonSize,
    );
  }
}
