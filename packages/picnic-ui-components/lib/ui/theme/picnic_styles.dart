import 'package:flutter/material.dart';
import 'package:picnic_ui_components/resources/fonts.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

//ignore_for_file: no-magic-number, prefer-trailing-comma, prefer-moving-to-variable
class PicnicStyles {
  //ignore: long-method
  factory PicnicStyles(PhoneSize size) {
    return PicnicStyles._(
      display20: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: _resolveSize(size, s: 36, m: 38, l: 38),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title40: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 24, m: 26, l: 26),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title30: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 20, m: 22, l: 22),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title20: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 16, m: 18, l: 20),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title10: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 14, m: 18, l: 18),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body40: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 16, m: 18, l: 20),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
      body30: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 16, m: 18, l: 20),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body20: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 14, m: 16, l: 18),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body10: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 12, m: 14, l: 16),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body0: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 12, m: 14, l: 14),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption30: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 16, m: 18, l: 18),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption20: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 14, m: 14, l: 16),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption10: TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 12, m: 12, l: 14),
        height: 1.3,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
    );
  }

  PicnicStyles._({
    required this.display20,
    required this.title40,
    required this.title30,
    required this.title20,
    required this.title10,
    required this.body40,
    required this.body30,
    required this.body20,
    required this.body10,
    required this.body0,
    required this.caption30,
    required this.caption20,
    required this.caption10,
  });

  static const String fontFamily = FontFamily.kanit;

  // If a caracter is not found in default font there is a callback to try find it again
  // For example, those fonts(ʚɞ) are not shown in android devices
  static const List<String> fontFamilyFallback = [FontFamily.arimo];

  final TextStyle display20;

  final TextStyle title40;
  final TextStyle title30;

  final TextStyle title20;
  final TextStyle title10;

  final TextStyle body40;
  final TextStyle body30;
  final TextStyle body20;
  final TextStyle body10;
  final TextStyle body0;

  final TextStyle caption30;
  final TextStyle caption20;
  final TextStyle caption10;

  static double _resolveSize(
    PhoneSize size, {
    required double s,
    required double m,
    required double l,
  }) {
    switch (size) {
      case PhoneSize.small:
        return s;
      case PhoneSize.medium:
        return m;
      case PhoneSize.large:
        return l;
    }
  }
}
