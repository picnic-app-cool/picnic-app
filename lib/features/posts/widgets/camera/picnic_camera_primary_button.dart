import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCameraPrimaryButton extends StatelessWidget {
  const PicnicCameraPrimaryButton({
    super.key,
    required this.onTap,
    this.child,
  });

  final VoidCallback onTap;
  final Widget? child;

  static const _buttonSize = 78.0;
  static const _buttonPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final color = blackAndWhite.shade100.withOpacity(0.23);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        padding: const EdgeInsets.all(_buttonPadding),
        width: _buttonSize,
        height: _buttonSize,
        child: child,
      ),
    );
  }
}
