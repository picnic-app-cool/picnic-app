import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

class CommentReport extends Equatable implements ViolationReport {
  const CommentReport({
    required this.spammer,
    required this.reporter,
    required this.commentId,
    required this.reportId,
    required this.status,
    required this.moderator,
    required this.resolvedAt,
  });

  const CommentReport.empty()
      : spammer = const BasicPublicProfile.empty(),
        reporter = const BasicPublicProfile.empty(),
        commentId = const Id.empty(),
        moderator = const BasicPublicProfile.empty(),
        reportId = const Id.empty(),
        resolvedAt = "",
        status = ResolveStatus.unknown;

  @override
  final BasicPublicProfile spammer;
  @override
  final BasicPublicProfile reporter;
  @override
  final BasicPublicProfile moderator;
  @override
  final String resolvedAt;
  final Id commentId;
  final Id reportId;

  @override
  final ResolveStatus status;

  @override
  ReportEntityType get reportType => ReportEntityType.comment;

  @override
  List<Object?> get props => [
        spammer,
        reporter,
        commentId,
        reportId,
        status,
        moderator,
        resolvedAt,
      ];

  CommentReport copyWith({
    BasicPublicProfile? spammer,
    BasicPublicProfile? reporter,
    Id? commentId,
    Id? reportId,
    ResolveStatus? status,
    BasicPublicProfile? moderator,
    String? resolvedAt,
  }) {
    return CommentReport(
      spammer: spammer ?? this.spammer,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      moderator: moderator ?? this.moderator,
      reporter: reporter ?? this.reporter,
      commentId: commentId ?? this.commentId,
      reportId: reportId ?? this.reportId,
      status: status ?? this.status,
    );
  }
}
