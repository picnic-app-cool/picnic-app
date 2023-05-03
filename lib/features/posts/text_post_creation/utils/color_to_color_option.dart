import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';

const _blueColors = [
  Color(0XFF86C8F5),
  Color(0XFF6AAAF5),
  Color(0XFF97A9F5),
];
const _purpleColors = [
  Color(0XFFBD86F5),
  Color(0XFFA76AF5),
  Color(0XFFA497F5),
];
const _yellowColors = [
  Color(0XFFEDD766),
  Color(0XFFE3C26E),
  Color(0XFFE4C383),
];
const _redColors = [
  Color(0XFFFF90AB),
  Color(0XFFF4779D),
  Color(0XFFFE9FC1),
];
const _greenColors = [
  Color(0XFF93DF78),
  Color(0XFF61DA7C),
  Color(0XFFA4DA7B),
];

LinearGradient colorToColorOption(TextPostColor color) {
  switch (color) {
    case TextPostColor.blue:
      return const LinearGradient(colors: _blueColors);
    case TextPostColor.purple:
      return const LinearGradient(colors: _purpleColors);
    case TextPostColor.yellow:
      return const LinearGradient(colors: _yellowColors);
    case TextPostColor.red:
      return const LinearGradient(colors: _redColors);
    case TextPostColor.green:
      return const LinearGradient(colors: _greenColors);
    case TextPostColor.none:
      return const LinearGradient(
        colors: [],
      );
  }
}
