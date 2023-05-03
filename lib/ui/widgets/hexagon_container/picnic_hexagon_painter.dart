import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/hexagon_container/picnic_hexagon_path_builder.dart';

class PicnicHexagonPainter extends CustomPainter {
  PicnicHexagonPainter({
    required this.pathBuilder,
    this.gradient,
    this.borderWidth,
  });

  final PicnicHexagonPathBuilder pathBuilder;
  final Gradient? gradient;
  final double? borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final path = pathBuilder.build(size);

    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth ?? 0
      ..shader = gradient?.createShader(
        Rect.fromCenter(
          center: center,
          width: size.width,
          height: size.height,
        ),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
