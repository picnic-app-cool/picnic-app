import 'package:picnic_app/features/reports/domain/model/report_reason.dart';

class ReportReasonsInitialParams {
  const ReportReasonsInitialParams({
    this.reasons = const [],
  });

  final List<ReportReason> reasons;
}
