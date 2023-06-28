import 'package:picnic_app/localization/app_localizations_utils.dart';

enum Gender {
  male(value: 'male'),
  female(value: 'female'),
  nonBinary(value: 'binary'),
  preferNotToSay(value: 'prefer-not-to-say'),
  unknown(value: 'unknown');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case Gender.male:
        return appLocalizations.male;
      case Gender.female:
        return appLocalizations.female;
      case Gender.nonBinary:
        return appLocalizations.nonBinary;
      case Gender.preferNotToSay:
        return appLocalizations.preferNotToSay;
      case Gender.unknown:
        return appLocalizations.unknown;
    }
  }

  const Gender({required this.value});

  static List<Gender> get allRoles => [
        male,
        female,
        nonBinary,
        preferNotToSay,
      ];

  static Gender fromString(String value) => Gender.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => Gender.unknown,
      );

  String toJson() {
    return value;
  }
}
