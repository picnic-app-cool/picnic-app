import 'package:picnic_app/features/reports/domain/model/report_input.dart';

extension GqlReportInputJson on ReportInput {
  Map<String, dynamic> toJson() {
    return {
      'anyId': anyId.value,
      'circleId': circleId.value,
      'reportType': reportType.stringVal,
      'reason': reason,
      'comment': comment,
      'contentAuthorId': contentAuthorId.value,
    };
  }
}
