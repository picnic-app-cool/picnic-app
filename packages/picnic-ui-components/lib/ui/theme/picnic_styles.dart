import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:picnic_ui_components/resources/fonts.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

//ignore_for_file: no-magic-number, prefer-trailing-comma, prefer-moving-to-variable
class PicnicStyles {
  //ignore: long-method
  factory PicnicStyles(PhoneSize size) {
    const baseTextStyle = TextStyle(fontFeatures: <FontFeature>[FontFeature('liga', 0)]);

    return PicnicStyles._(
      display50: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 48, m: 48, l: 50),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      display40: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 42, m: 42, l: 44),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      display30: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 36, m: 36, l: 38),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      display20: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 34, m: 34, l: 36),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      display10: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 30, m: 30, l: 32),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title60: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 26, m: 26, l: 29),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title50: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 22, m: 22, l: 24),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title40: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 19, m: 19, l: 21),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title30: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 18, m: 18, l: 20),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title20: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 16, m: 16, l: 18),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title15: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 15, m: 15, l: 17),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      title10: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: _resolveSize(size, s: 14, m: 14, l: 16),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      link40: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 19, m: 19, l: 21),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      link30: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 18, m: 18, l: 20),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      link20: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 16, m: 16, l: 18),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      link15: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 15, m: 15, l: 17),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      link10: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 14, m: 14, l: 16),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      link0: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w600,
        fontSize: _resolveSize(size, s: 12, m: 12, l: 14),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      subtitle40: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 19, m: 19, l: 21),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      subtitle30: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 18, m: 18, l: 20),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      subtitle20: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 16, m: 16, l: 18),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      subtitle15: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 15, m: 15, l: 17),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      subtitle10: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 14, m: 14, l: 16),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      subtitle0: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w500,
        fontSize: _resolveSize(size, s: 12, m: 12, l: 14),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body40: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 19, m: 19, l: 21),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
      body30: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 18, m: 18, l: 20),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body20: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 16, m: 16, l: 18),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body15: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 15, m: 15, l: 17),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body10: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 14, m: 14, l: 16),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      body0: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w400,
        fontSize: _resolveSize(size, s: 12, m: 12, l: 14),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption40: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 19, m: 19, l: 21),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption30: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 18, m: 18, l: 20),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption20: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 16, m: 16, l: 18),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption15: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 15, m: 15, l: 17),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      caption10: baseTextStyle.copyWith(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: _resolveSize(size, s: 14, m: 14, l: 16),
        height: 1.2,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
    );
  }

  PicnicStyles._({
    required this.display50,
    required this.display40,
    required this.display30,
    required this.display20,
    required this.display10,
    required this.title60,
    required this.title50,
    required this.title40,
    required this.title30,
    required this.title20,
    required this.title15,
    required this.title10,
    required this.link40,
    required this.link30,
    required this.link20,
    required this.link15,
    required this.link10,
    required this.link0,
    required this.subtitle40,
    required this.subtitle30,
    required this.subtitle20,
    required this.subtitle15,
    required this.subtitle10,
    required this.subtitle0,
    required this.body40,
    required this.body30,
    required this.body20,
    required this.body15,
    required this.body10,
    required this.body0,
    required this.caption40,
    required this.caption30,
    required this.caption20,
    required this.caption15,
    required this.caption10,
  });

  static const String fontFamily = FontFamily.figtree;

  // If a caracter is not found in default font there is a callback to try find it again
  // For example, those fonts(ʚɞ) are not shown in android devices
  static const List<String> fontFamilyFallback = [FontFamily.arimo];

  final TextStyle display50;
  final TextStyle display40;
  final TextStyle display30;
  final TextStyle display20;
  final TextStyle display10;

  final TextStyle title60;
  final TextStyle title50;
  final TextStyle title40;
  final TextStyle title30;
  final TextStyle title20;
  final TextStyle title15;
  final TextStyle title10;

  final TextStyle link40;
  final TextStyle link30;
  final TextStyle link20;
  final TextStyle link15;
  final TextStyle link10;
  final TextStyle link0;

  final TextStyle subtitle40;
  final TextStyle subtitle30;
  final TextStyle subtitle20;
  final TextStyle subtitle15;
  final TextStyle subtitle10;
  final TextStyle subtitle0;

  final TextStyle body40;
  final TextStyle body30;
  final TextStyle body20;
  final TextStyle body15;
  final TextStyle body10;
  final TextStyle body0;

  final TextStyle caption40;
  final TextStyle caption30;
  final TextStyle caption20;
  final TextStyle caption15;
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
