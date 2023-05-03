import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/hexagon_container/picnic_hexagon_clipper.dart';
import 'package:picnic_app/ui/widgets/hexagon_container/picnic_hexagon_painter.dart';
import 'package:picnic_app/ui/widgets/hexagon_container/picnic_hexagon_path_builder.dart';

class PicnicHexagonContainer extends StatelessWidget {
  const PicnicHexagonContainer({
    required this.child,
    this.gradient,
    this.borderWidth,
    this.borderRadius = 0,
    super.key,
  });

  final Widget child;
  final Gradient? gradient;
  final double? borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final pathBuilder = PicnicHexagonPathBuilder(borderRadius: borderRadius);
    final clipper = PicnicHexagonClipper(pathBuilder);

    return CustomPaint(
      painter: PicnicHexagonPainter(
        pathBuilder: pathBuilder,
        gradient: gradient,
        borderWidth: borderWidth,
      ),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}
