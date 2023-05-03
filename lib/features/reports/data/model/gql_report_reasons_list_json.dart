import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/reports/data/model/gql_report_reason_json.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';

//ignore_for_file: unused-code, unused-files
class GqlReportReasonsListJson {
  const GqlReportReasonsListJson({
    required this.reportReasons,
  });

  factory GqlReportReasonsListJson.fromJson(Map<String, dynamic> json) => GqlReportReasonsListJson(
        reportReasons: asList(
          json,
          'reportReasons',
          GqlReportReasonJson.fromJson,
        ),
      );

  final List<GqlReportReasonJson> reportReasons;

  List<ReportReason> toDomain() => reportReasons.map((x) => x.toDomain()).toList();
}
