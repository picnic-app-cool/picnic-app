import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

class ReportedContentInitialParams {
  const ReportedContentInitialParams({
    required this.author,
    required this.circleId,
    required this.reportId,
    required this.reportType,
  });

  final MinimalPublicProfile author;
  final Id circleId;
  final Id reportId;
  final ReportEntityType reportType;
}
