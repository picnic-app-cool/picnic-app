import 'package:picnic_app/localization/app_localizations_utils.dart';

enum CircleReportsFilterBy {
  allReports(value: 'ALL'),
  unresolved(value: 'UNRESOLVED'),
  resolved(value: 'RESOLVED');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case CircleReportsFilterBy.allReports:
        return '📃 ${appLocalizations.allReports}';
      case CircleReportsFilterBy.unresolved:
        return '⏳ ${appLocalizations.unresolved}';
      case CircleReportsFilterBy.resolved:
        return '✅ ${appLocalizations.resolved}';
    }
  }

  const CircleReportsFilterBy({required this.value});

  static List<CircleReportsFilterBy> get allSorts => [
        allReports,
        unresolved,
        resolved,
      ];

  static CircleReportsFilterBy fromString(String value) => CircleReportsFilterBy.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => CircleReportsFilterBy.allReports,
      );

  String toJson() {
    return value;
  }
}
