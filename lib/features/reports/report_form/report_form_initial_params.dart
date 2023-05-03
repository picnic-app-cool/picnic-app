import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

class ReportFormInitialParams {
  const ReportFormInitialParams({
    // TODO: Make all required when all project places will be ready for it
    this.entityId = const Id.empty(),
    this.reportEntityType = ReportEntityType.all,
    this.circleId = const Id.empty(),
    this.sliceId = const Id.empty(),
    this.contentAuthorId = const Id.empty(),
  });

  final Id entityId;
  final ReportEntityType reportEntityType;
  final Id circleId;
  final Id contentAuthorId;
  final Id sliceId;
}
