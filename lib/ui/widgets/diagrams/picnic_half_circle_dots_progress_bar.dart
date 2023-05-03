import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicHalfCircleDotsProgressBar extends StatelessWidget {
  const PicnicHalfCircleDotsProgressBar({
    Key? key,
    required this.progress,
    this.height = _defaultHeight,
    this.dotRadius = _defaultDotRadius,
    this.startBarRadius = _defaultStartBarRadius,
    this.layers = _defaultLayers,
    this.layersSpacing = _defaultLayersSpacing,
    this.dotsSpacing = _defaultDotsSpacing,
  }) : super(key: key);

  final double height;
  final double dotRadius;
  final double startBarRadius;
  final int layers;
  final double layersSpacing;
  final double dotsSpacing;
  final double progress;

  static const _defaultHeight = 163.0;
  static const _defaultDotRadius = 3.31;
  static const _defaultStartBarRadius = 68.5;
  static const _defaultLayers = 11;
  static const _defaultLayersSpacing = 1.65;
  static const _defaultDotsSpacing = 1.21;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _DiagramPainter(
          dotRadius: dotRadius,
          startBarRadius: startBarRadius,
          layers: layers,
          layersSpacing: layersSpacing,
          dotsSpacing: dotsSpacing,
          progress: progress,
          dotColor: colors.blackAndWhite.shade300,
          progressDotColor: colors.blue.shade500,
        ),
      ),
    );
  }
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter({
    required this.dotRadius,
    required this.startBarRadius,
    required this.layers,
    required this.layersSpacing,
    required this.dotsSpacing,
    required this.progress,
    required Color dotColor,
    required Color progressDotColor,
  })  : _paint = Paint()
          ..color = dotColor
          ..style = PaintingStyle.fill,
        _progressPaint = Paint()
          ..color = progressDotColor
          ..style = PaintingStyle.fill,
        _dotDiameter = dotRadius + dotRadius;

  final double dotRadius;
  final double startBarRadius;
  final int layers;
  final double layersSpacing;
  final double dotsSpacing;
  final double progress;

  final Paint _paint;
  final Paint _progressPaint;

  final double _dotDiameter;

  static const _startAngle = 270.0;
  static const _circle = 360.0;
  static const _halfCircle = 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.bottomCenter(Offset(-dotRadius, -dotRadius));

    var radius = startBarRadius;

    for (var layer = 0; layer < layers; layer++) {
      final lengthOfHalfCircle = pi * radius;
      final dotsSizeWithSpacing = _dotDiameter + dotsSpacing;

      final items = (lengthOfHalfCircle / dotsSizeWithSpacing).floor() - 1;

      final angleStep = _halfCircle / items;
      var angle = _startAngle;

      final progressItems = ((items + 1) * progress).toInt();

      for (var dot = 0; dot <= items; dot++) {
        final radian = pi * 2 * angle / _circle;

        canvas.drawCircle(
          Offset(
            radius * sin(radian) + center.dx,
            radius * cos(radian) + center.dy,
          ),
          dotRadius,
          dot < progressItems ? _progressPaint : _paint,
        );

        angle -= angleStep;
      }

      radius += _dotDiameter + layersSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant _DiagramPainter oldDelegate) =>
      dotRadius != oldDelegate.dotRadius ||
      startBarRadius != oldDelegate.startBarRadius ||
      layers != oldDelegate.layers ||
      layersSpacing != oldDelegate.layersSpacing ||
      dotsSpacing != oldDelegate.dotsSpacing ||
      progress != oldDelegate.progress;
}
