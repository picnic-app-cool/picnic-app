import 'package:picnic_app/localization/app_localizations_utils.dart';

enum CircleReportReason {
  sexualContent(value: 'SEXUAL_CONTENT'),
  graphicContent(value: 'GRAPHIC_CONTENT'),
  spam(value: 'SPAM'),
  other(value: 'OTHER');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case sexualContent:
        return appLocalizations.circleReasonSexualContent;
      case graphicContent:
        return appLocalizations.circleReasonGraphicContent;
      case spam:
        return appLocalizations.circleReasonSpam;
      case other:
        return appLocalizations.circleReasonOther;
    }
  }

  const CircleReportReason({required this.value});

  static List<CircleReportReason> get allCircleReasons => [
        other,
        spam,
        sexualContent,
        graphicContent,
      ];

  static CircleReportReason fromString(String value) => CircleReportReason.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => CircleReportReason.other,
      );

  String toJson() {
    return value;
  }
}
