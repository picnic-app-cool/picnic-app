import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';

//ignore_for_file: unused-code, unused-files
class GqlReportReasonJson {
  const GqlReportReasonJson({
    required this.id,
    required this.reason,
  });

  factory GqlReportReasonJson.fromJson(Map<String, dynamic>? json) => GqlReportReasonJson(
        id: asT<String>(json, 'id'),
        reason: asT<String>(json, 'reason'),
      );

  final String id;
  final String reason;

  ReportReason toDomain() => ReportReason(
        id: Id(id),
        reason: reason,
      );
}
