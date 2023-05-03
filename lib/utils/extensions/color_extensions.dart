import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// determines if the color is light or dark based on its red/green/blue parts average value
  //ignore: no-magic-number
  bool get isLightColor => (red + green + blue) / 3 > 128;
}
