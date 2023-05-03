import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';

extension GqlCreateReportInputJson on CreateReportInput {
  Map<String, dynamic> toJson() {
    return {
      'entityID': entityId.value,
      'entity': entity.stringVal,
      'reason': reason,
      'description': description,
    };
  }
}
