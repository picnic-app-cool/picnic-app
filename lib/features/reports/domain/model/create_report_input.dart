import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

class CreateReportInput extends Equatable {
  const CreateReportInput({
    required this.entityId,
    required this.entity,
    required this.reason,
    required this.description,
  });

  const CreateReportInput.empty()
      : entityId = const Id.empty(),
        entity = ReportEntityType.unknown,
        reason = '',
        description = '';

  final Id entityId;
  final ReportEntityType entity;
  final String reason;
  final String description;

  @override
  List<Object> get props => [
        entityId,
        entity,
        reason,
        description,
      ];

  CreateReportInput copyWith({
    Id? entityId,
    ReportEntityType? entity,
    String? reason,
    String? description,
  }) {
    return CreateReportInput(
      entityId: entityId ?? this.entityId,
      entity: entity ?? this.entity,
      reason: reason ?? this.reason,
      description: description ?? this.description,
    );
  }
}
