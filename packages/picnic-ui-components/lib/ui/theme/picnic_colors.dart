import 'package:flutter/material.dart';

class PicnicColors {
  static const Color primaryButtonBlue = Color(0xFFF1F7FC);
  static const Color primaryTabBlue = Color(0xFF39487C);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color bluishCyan = Color(0xFF45BAEC);
  static const Color grey = Color(0xFF777777);
  static const Color paleGrey = Color(0x0D2B3F6C);

  static const borderBlue = Color(0xFF84C4FF);

  final MaterialColor blue = const MaterialColor(
    _primaryBlue,
    {
      100: Color(0xFFE8F1FF),
      200: Color(0xFFBBD6FF),
      300: Color(0xFF8EBBFF),
      400: Color(0xFF61A0FF),
      500: Color(_primaryBlue),
      600: Color(0xFF1453B3),
      700: Color(0xFF0F3C80),
      800: Color(0xFF09244C),
      900: Color(0xFF030C19),
    },
  );
  final MaterialColor indigo = const MaterialColor(
    _primaryIndigo,
    {
      100: Color(0xFFECE8FF),
      200: Color(0xFFC5BBFF),
      300: Color(0xFF9E8EFF),
      400: Color(0xFF7761FF),
      500: Color(_primaryIndigo),
      600: Color(0xFF2A14B3),
      700: Color(0xFF1E0F80),
      800: Color(0xFF12094C),
      900: Color(0xFF060319),
    },
  );

  final MaterialColor purple = const MaterialColor(
    _primaryPurple,
    {
      100: Color(0xFFF2EBFF),
      200: Color(0xFFD9C2FF),
      300: Color(0xFFC09AFF),
      400: Color(0xFFA771FF),
      500: Color(_primaryPurple),
      600: Color(0xFF5A24B3),
      700: Color(0xFF411A80),
      800: Color(0xFF27104C),
      900: Color(0xFF0D0519),
    },
  );

  final MaterialColor pink = const MaterialColor(
    _primaryPink,
    {
      100: Color(0xFFFFEFF2),
      200: Color(0xFFFFCED7),
      300: Color(0xFFFFBECA),
      400: Color(0xFFFF7D95),
      500: Color(_primaryPink),
      600: Color(0xFFCC4A62),
      700: Color(0xFF99384A),
      800: Color(0xFF4C1C25),
      900: Color(0xFF19090C),
    },
  );

  final MaterialColor red = const MaterialColor(
    _primaryRed,
    {
      100: Color(0xFFFFEBEE),
      200: Color(0xFFFFC2CD),
      300: Color(0xFFFF9AAC),
      400: Color(0xFFFF718B),
      500: Color(_primaryRed),
      600: Color(0xFFB3243E),
      700: Color(0xFF801A2D),
      800: Color(0xFF4C101B),
      900: Color(0xFF190509),
    },
  );

  final MaterialColor orange = const MaterialColor(
    _primaryOrange,
    {
      100: Color(0xFFFFF0EB),
      200: Color(0xFFFFD1C2),
      300: Color(0xFFFFB29A),
      400: Color(0xFFFF9371),
      500: Color(_primaryOrange),
      600: Color(0xFFB34724),
      700: Color(0xFF80331A),
      800: Color(0xFF4C1E10),
      900: Color(0xFF190A05),
    },
  );

  final MaterialColor yellow = const MaterialColor(
    _primaryYellow,
    {
      100: Color(0xFFFFFAEA),
      200: Color(0xFFFFF1C0),
      300: Color(0xFFFFE896),
      400: Color(0xFFFFDF6C),
      500: Color(_primaryYellow),
      600: Color(0xFFB3921F),
      700: Color(0xFF806917),
      800: Color(0xFF4C3F0D),
      900: Color(0xFF191504),
    },
  );

  final MaterialColor lime = const MaterialColor(
    _primaryLime,
    {
      100: Color(0xFFF8FDEC),
      200: Color(0xFFEBF8C5),
      300: Color(0xFFDEF49E),
      400: Color(0xFFD0F077),
      500: Color(_primaryLime),
      600: Color(0xFF84A32A),
      700: Color(0xFF5E751E),
      800: Color(0xFF384612),
      900: Color(0xFF131706),
    },
  );

  final MaterialColor green = const MaterialColor(
    _primaryGreen,
    {
      100: Color(0xFFF5FCF2),
      200: Color(0xFFE0F6D8),
      300: Color(0xFFC0ECB0),
      400: Color(0xFFABE696),
      500: Color(_primaryGreen),
      600: Color(0xFF78B363),
      700: Color(0xFF4B703E),
      800: Color(0xFF2D4325),
      900: Color(0xFF0F160C),
    },
  );

  final MaterialColor teal = const MaterialColor(
    _primaryTeal,
    {
      100: Color(0xFFECFDFA),
      200: Color(0xFFC5F8EF),
      300: Color(0xFF9EF4E5),
      400: Color(0xFF77F0DA),
      500: Color(_primaryTeal),
      600: Color(0xFF78B363),
      700: Color(0xFF1E7565),
      800: Color(0xFF12463D),
      900: Color(0xFF061714),
    },
  );

  final MaterialColor cyan = const MaterialColor(
    _primaryCyan,
    {
      100: Color(0xFFECFDFD),
      200: Color(0xFFC5F8F8),
      300: Color(0xFF9EF4F4),
      400: Color(0xFF77F0F0),
      500: Color(_primaryCyan),
      600: Color(0xFF2AA3A3),
      700: Color(0xFF1E7575),
      800: Color(0xFF124646),
      900: Color(0xFF061717),
    },
  );

  final MaterialColor lightBlue = const MaterialColor(
    _primaryLightBlue,
    {
      100: Color(0xFFF0FBFF),
      200: Color(0xFFD2F2FF),
      300: Color(0xFFB4E9FF),
      400: Color(0xFF95E0FF),
      500: Color(_primaryLightBlue),
      600: Color(0xFF4993B3),
      700: Color(0xFF346980),
      800: Color(0xFF1F3F4C),
      900: Color(0xFF0A1519),
    },
  );

  final MaterialColor darkBlue = const MaterialColor(
    _primaryDarkBlue,
    {
      100: Color(0xFFF1F7FC),
      200: Color(0xFFC0C4D5),
      300: Color(0xFF818AAB),
      400: Color(0xFF616D96),
      500: Color(_primaryDarkBlue),
      600: Color(0xFF2B3F6C),
      700: Color(0xFF122740),
      800: Color(0xFF0E1F33),
      900: Color(0xFF101820),
    },
  );

  final MaterialColor blackAndWhite = const MaterialColor(
    _primaryBlackWhite,
    {
      100: Color(0xFFFFFFFF),
      200: Color(0xFFF9F9F9),
      300: Color(0xFFE6E6E6),
      400: Color(0xFFCCCCCC),
      500: Color(_primaryBlackWhite),
      600: Color(0xFF808080),
      700: Color(0xFF333333),
      800: Color(0xFF191919),
      900: Color(0xFF000000),
    },
  );

  static const LinearGradient rainbowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF173),
      Color(0xFFFF8D74),
      Color(0xFFE96685),
      Color(0xFFB75BFF),
      Color(0xFF81C3FF),
      Color(0xFF74FFE6),
    ],
    stops: [
      .1,
      .3,
      .45,
      .6,
      .75,
      1,
    ],
  );

  static const LinearGradient rainbowGradientCircleMod = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF173),
      Color(0xFFFF8D74),
      Color(0xFFE96685),
      Color(0xFFB75BFF),
      Color(0xFF81C3FF),
      Color(0xFF74FFE6),
    ],
    stops: [
      .07,
      .25,
      .4,
      .6,
      .8,
      1,
    ],
  );

  static const int _primaryBlue = 0xFF1D77FF;
  static const int _primaryIndigo = 0xFF5034FF;
  static const int _primaryPurple = 0xFF8134FF;
  static const int _primaryPink = 0xFFFF5D7B;
  static const int _primaryRed = 0xFFFF3459;
  static const int _primaryOrange = 0xFFFF6534;
  static const int _primaryYellow = 0xFFE8C23E;
  static const int _primaryLime = 0xFFBCE93C;
  static const int _primaryGreen = 0xFF96E07C;
  static const int _primaryTeal = 0xFF3ED9BD;
  static const int _primaryCyan = 0xFF3CE9E9;
  static const int _primaryLightBlue = 0xFF68D2FF;
  static const int _primaryDarkBlue = 0xFF39487C;
  static const int _primaryBlackWhite = 0xFFB3B3B3;

  Color get activeTabColor => primaryTabBlue;

  //ignore: no-magic-number
  Color get shadow50 => blackAndWhite.shade900.withOpacity(0.5);
}
