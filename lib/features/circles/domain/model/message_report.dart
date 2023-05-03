import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

class MessageReport extends Equatable implements ViolationReport {
  const MessageReport({
    required this.spammer,
    required this.reporter,
    required this.messageId,
    required this.reportId,
    required this.status,
    required this.moderator,
    required this.resolvedAt,
  });

  const MessageReport.empty()
      : spammer = const BasicPublicProfile.empty(),
        reporter = const BasicPublicProfile.empty(),
        messageId = const Id.empty(),
        moderator = const BasicPublicProfile.empty(),
        reportId = const Id.empty(),
        resolvedAt = "",
        status = ResolveStatus.unknown;

  final Id messageId;
  final Id reportId;

  @override
  final BasicPublicProfile spammer;
  @override
  final BasicPublicProfile reporter;
  @override
  final BasicPublicProfile moderator;

  @override
  final String resolvedAt;

  @override
  final ResolveStatus status;

  @override
  ReportEntityType get reportType => ReportEntityType.message;

  @override
  List<Object?> get props => [
        spammer,
        reporter,
        messageId,
        reportId,
        status,
        moderator,
        resolvedAt,
      ];

  MessageReport copyWith({
    BasicPublicProfile? spammer,
    BasicPublicProfile? reporter,
    Id? messageId,
    Id? reportId,
    ResolveStatus? status,
    BasicPublicProfile? moderator,
    String? resolvedAt,
  }) {
    return MessageReport(
      spammer: spammer ?? this.spammer,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      moderator: moderator ?? this.moderator,
      reporter: reporter ?? this.reporter,
      messageId: messageId ?? this.messageId,
      reportId: reportId ?? this.reportId,
      status: status ?? this.status,
    );
  }
}
