import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

class ReportInput extends Equatable {
  const ReportInput({
    required this.anyId,
    required this.circleId,
    required this.reportType,
    required this.reason,
    required this.comment,
    required this.contentAuthorId,
  });

  const ReportInput.empty()
      : anyId = const Id.empty(),
        circleId = const Id.empty(),
        reportType = ReportEntityType.unknown,
        reason = '',
        comment = '',
        contentAuthorId = const Id.empty();

  final Id anyId;
  final Id circleId;
  final ReportEntityType reportType;
  final String reason;
  final String comment;
  final Id contentAuthorId;

  @override
  List<Object> get props => [
        anyId,
        circleId,
        reportType,
        reason,
        comment,
        contentAuthorId,
      ];

  ReportInput copyWith({
    Id? anyId,
    Id? circleId,
    ReportEntityType? reportType,
    String? reason,
    String? comment,
    Id? contentAuthorId,
  }) {
    return ReportInput(
      anyId: anyId ?? this.anyId,
      circleId: circleId ?? this.circleId,
      reportType: reportType ?? this.reportType,
      reason: reason ?? this.reason,
      comment: comment ?? this.comment,
      contentAuthorId: contentAuthorId ?? this.contentAuthorId,
    );
  }
}
