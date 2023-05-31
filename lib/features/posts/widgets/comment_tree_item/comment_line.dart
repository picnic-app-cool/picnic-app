import 'package:flutter/material.dart';

class CommentLine extends StatelessWidget {
  const CommentLine({
    required this.color,
    Key? key,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PathPainter(
        color: color,
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  const _PathPainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    var path = Path();
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
