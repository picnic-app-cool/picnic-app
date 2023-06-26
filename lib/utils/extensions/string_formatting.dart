import 'package:intl/intl.dart';

extension StringFormatting on String {
  String get formattedUsername => "@$this";

  String get formattedCircleName => "+$this";
}

extension ToIntOrZero on String {
  int get toIntOrZero => int.tryParse(this) ?? 0;
}

extension DoubleStringFormatting on double {
  static final NumberFormat priceFormatter = NumberFormat()
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 1;

  //ignore: no-magic-number
  String get formattedPercentage => "${(this * 100).round()}%";

  String get formattedPrice => priceFormatter.format(this);
}

extension DurationStringFormatting on Duration {
  String get formatteds => DateFormat("s") //
          .format(
        //ignore: prefer-trailing-comma
        DateTime(2020, 12, 12) //
            .add(this)
            .add(const Duration(milliseconds: 500)),
      );

  String get formattedMMss => DateFormat("mm:ss") //
          .format(
        //ignore: prefer-trailing-comma
        DateTime(2020, 12, 12) //
            .add(this)
            .add(const Duration(milliseconds: 500)),
      );

  String get formattedHH => DateFormat("HH") //
          .format(
        //ignore: prefer-trailing-comma
        DateTime(2020, 12, 12) //
            .add(this)
            .add(const Duration(milliseconds: 500)),
      );
}
