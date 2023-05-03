import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';

// ignore_for_file: unused-code, unused-files
class PicnicRainbowCircularBorder extends StatelessWidget {
  const PicnicRainbowCircularBorder({
    required this.childSize,
    required this.borderWidth,
    required this.child,
    super.key,
  });

  final double childSize;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = childSize + (borderWidth * 2);

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: PicnicColors.rainbowGradient,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
