import 'package:flutter/material.dart' show BuildContext;
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

extension ResponsiveExtensions on BuildContext {
  T responsiveValue<T>({
    required T small,
    required T medium,
    required T large,
  }) {
    final phoneSize = PicnicTheme.of(this).phoneSize;
    switch (phoneSize) {
      case PhoneSize.small:
        return small;
      case PhoneSize.medium:
        return medium;
      case PhoneSize.large:
        return large;
    }
  }

  T responsive<T>({
    required T Function() small,
    required T Function() medium,
    required T Function() large,
  }) {
    final phoneSize = PicnicTheme.of(this).phoneSize;
    switch (phoneSize) {
      case PhoneSize.small:
        return small();
      case PhoneSize.medium:
        return medium();
      case PhoneSize.large:
        return large();
    }
  }
}
