import 'dart:math';
import 'dart:ui';

class PicnicHexagonPathBuilder {
  PicnicHexagonPathBuilder({this.borderRadius = 0});

  final double borderRadius;

  static const _hex = 6;
  static const _fraction = 0.7698;

  Path build(Size size) => _hexagonPath(size);

  Path _hexagonPath(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final cornerList = _pointyHexagonCornerList(center, size.height / 1 / 2);
    final path = Path();

    if (borderRadius > 0) {
      _createPathWithBorder(path: path, cornerList: cornerList);
    } else {
      _createPathWithoutBorder(path: path, cornerList: cornerList);
    }

    return path..close();
  }

  // ignore: long-method
  void _createPathWithBorder({
    required Path path,
    required List<Point<double>> cornerList,
  }) {
    final distance = _calculateDistance(borderRadius);
    cornerList.asMap().forEach((index, point) {
      final rStart = _radiusStart(
        corner: point,
        index: index,
        cornerList: cornerList,
        distance: distance,
      );
      final rEnd = _radiusEnd(
        corner: point,
        index: index,
        cornerList: cornerList,
        distance: distance,
      );
      if (index == 0) {
        path.moveTo(rStart.x, rStart.y);
      } else {
        path.lineTo(rStart.x, rStart.y);
      }
      final control1 = _pointBetween(
        start: rStart,
        end: point,
        fraction: _fraction,
      );
      final control2 = _pointBetween(
        start: rEnd,
        end: point,
        fraction: _fraction,
      );
      path.cubicTo(
        control1.x,
        control1.y,
        control2.x,
        control2.y,
        rEnd.x,
        rEnd.y,
      );
    });
  }

  void _createPathWithoutBorder({
    required Path path,
    required List<Point<double>> cornerList,
  }) {
    cornerList.asMap().forEach((index, point) {
      if (index == 0) {
        path.moveTo(point.x, point.y);
      } else {
        path.lineTo(point.x, point.y);
      }
    });
  }

  List<Point<double>> _pointyHexagonCornerList(Offset center, double size) => List<Point<double>>.generate(
        _hex,
        (index) => _pointyHexagonCorner(
          center: center,
          size: size,
          index: index,
        ),
        growable: false,
      );

  Point<double> _pointyHexagonCorner({
    required Offset center,
    required double size,
    required int index,
  }) {
    var angleDeg = 60 * index - 30;
    var angleRad = pi / 180 * angleDeg;

    return Point(
      center.dx + size * cos(angleRad),
      center.dy + size * sin(angleRad),
    );
  }

  Point<double> _radiusStart({
    required Point<double> corner,
    required int index,
    required List<Point<double>> cornerList,
    required double distance,
  }) {
    final prevCorner = index > 0 ? cornerList[index - 1] : cornerList.last;
    final fraction = _calculateFraction(
      start: corner,
      end: prevCorner,
      distance: distance,
    );

    return _pointBetween(
      start: corner,
      end: prevCorner,
      fraction: fraction,
    );
  }

  Point<double> _radiusEnd({
    required Point<double> corner,
    required int index,
    required List<Point<double>> cornerList,
    required double distance,
  }) {
    final nextCorner = index < cornerList.length - 1 ? cornerList[index + 1] : cornerList.first;
    final fraction = _calculateFraction(
      start: corner,
      end: nextCorner,
      distance: distance,
    );

    return _pointBetween(
      start: corner,
      end: nextCorner,
      fraction: fraction,
    );
  }

  Point<double> _pointBetween({
    required Point<double> start,
    required Point<double> end,
    required double fraction,
  }) {
    final xLength = end.x - start.x;
    final yLength = end.y - start.y;

    return Point(
      start.x + xLength * fraction,
      start.y + yLength * fraction,
    );
  }

  double _calculateFraction({
    required Point<double> start,
    required Point<double> end,
    required double distance,
  }) {
    final xLength = end.x - start.x;
    final yLength = end.y - start.y;
    final length = sqrt(xLength * xLength + yLength * yLength);

    return distance / length;
  }

  double _calculateDistance(double radius) => radius * tan(pi / _hex);
}
