import 'package:flutter/rendering.dart';

class VideoScrubbingProgressColors {
  VideoScrubbingProgressColors({
    Color playedColor = const Color.fromRGBO(
      255,
      0,
      0,
      0.7,
    ),
    Color handleColor = const Color.fromRGBO(
      200,
      200,
      200,
      1.0,
    ),
    Color backgroundColor = const Color.fromRGBO(
      200,
      200,
      200,
      0.5,
    ),
  })  : playedPaint = Paint()..color = playedColor,
        handlePaint = Paint()..color = handleColor,
        backgroundPaint = Paint()..color = backgroundColor;

  final Paint playedPaint;
  final Paint handlePaint;
  final Paint backgroundPaint;
}
