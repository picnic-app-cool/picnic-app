import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/hexagon_container/picnic_hexagon_container.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';

class CircleModAvatar extends StatelessWidget {
  const CircleModAvatar({
    required this.child,
    super.key,
  });

  final Widget child;

  static const borderWidth = 6.0;
  static const borderRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    return PicnicHexagonContainer(
      gradient: PicnicColors.rainbowGradientCircleMod,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      child: child,
    );
  }
}
