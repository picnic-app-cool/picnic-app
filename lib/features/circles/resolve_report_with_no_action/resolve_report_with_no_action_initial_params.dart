import 'package:picnic_app/features/chat/domain/model/id.dart';

class ResolveReportWithNoActionInitialParams {
  const ResolveReportWithNoActionInitialParams({
    required this.circleId,
    required this.reportId,
  });

  final Id circleId;
  final Id reportId;
}
