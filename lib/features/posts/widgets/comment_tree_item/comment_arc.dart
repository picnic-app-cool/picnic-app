import 'package:flutter/material.dart';

class CommentArc extends StatelessWidget {
  const CommentArc({
    required this.size,
    required this.color,
    Key? key,
  }) : super(key: key);

  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _PathPainter(
          color: color,
        ),
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
    path.quadraticBezierTo(
      0,
      size.height,
      size.width,
      size.height,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
