import 'package:picnic_app/localization/app_localizations_utils.dart';

enum CircleModerationType {
  director('DIRECTOR'),
  democratic('DEMOCRATIC');

  final String value;

  const CircleModerationType(this.value);

  String get label {
    switch (this) {
      case director:
        return appLocalizations.ruleSelectionRadioLabelOne;
      case democratic:
        return appLocalizations.ruleSelectionRadioLabelTwo;
    }
  }

  static CircleModerationType fromString(String value) => CircleModerationType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => CircleModerationType.director,
      );
}
