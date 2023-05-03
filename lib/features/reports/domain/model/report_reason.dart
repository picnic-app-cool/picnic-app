import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ReportReason extends Equatable {
  const ReportReason({
    required this.id,
    required this.reason,
  });

  const ReportReason.empty()
      : id = const Id.empty(),
        reason = '';

  final Id id;
  final String reason;

  @override
  List<Object> get props => [
        id,
        reason,
      ];

  ReportReason copyWith({
    Id? id,
    String? reason,
  }) {
    return ReportReason(
      id: id ?? this.id,
      reason: reason ?? this.reason,
    );
  }
}
