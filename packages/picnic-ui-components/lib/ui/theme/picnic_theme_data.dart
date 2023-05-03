import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_styles.dart';

class PicnicThemeData {
  factory PicnicThemeData(Size screenSize) {
    // TODO: Pick this up from the core utils when the core is extracted out to a new package
    // debugLog("Determined phone size: $phoneSize");
    return PicnicThemeData._(
      PicnicColors(),
      PicnicStyles(PhoneSize.fromScreenSize(screenSize)),
      screenSize,
    );
  }

  PicnicThemeData._(
    this.colors,
    this.styles,
    this._screenSize,
  );

  final PicnicColors colors;
  final PicnicStyles styles;
  final Size _screenSize;

  PhoneSize get phoneSize => PhoneSize.fromScreenSize(_screenSize);

  ThemeData get materialThemeData => ThemeData(
        scaffoldBackgroundColor: colors.blackAndWhite[100],
      );
}

enum PhoneSize {
  small,
  medium,
  large;

  //428px × 926px - iphone 13 pro max
  //390px × 844px - iphone 13 pro
  //375px x 667px - iphone 8 - scale 1
  static PhoneSize fromScreenSize(Size size) {
    const iphone8 = 375;
    const iphonePro = 390;
    if (size.width <= iphone8) {
      return PhoneSize.small;
    } else if (size.width <= iphonePro) {
      return PhoneSize.medium;
    } else {
      return PhoneSize.large;
    }
  }
}
