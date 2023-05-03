import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

class PostReport extends Equatable implements ViolationReport {
  const PostReport({
    required this.post,
    required this.reportId,
    required this.status,
    required this.moderator,
    required this.resolvedAt,
    required this.spammer,
    required this.reporter,
  });

  const PostReport.empty()
      : post = const Post.empty(),
        reportId = const Id.empty(),
        moderator = const BasicPublicProfile.empty(),
        resolvedAt = '',
        status = ResolveStatus.unknown,
        spammer = const BasicPublicProfile.empty(),
        reporter = const BasicPublicProfile.empty();

  final Post post;
  final Id reportId;

  @override
  final String resolvedAt;

  @override
  final BasicPublicProfile moderator;

  @override
  final BasicPublicProfile spammer;

  @override
  final BasicPublicProfile reporter;

  @override
  final ResolveStatus status;

  @override
  ReportEntityType get reportType => ReportEntityType.post;

  PostType get postType => post.type;

  String get circleName => post.circleTag;

  BasicPublicProfile get user => post.author;

  String get username => post.author.username;

  bool get isVerified => post.author.isVerified;

  String get reporterUsername => reporter.username;

  @override
  List<Object?> get props => [
        post,
        reportId,
        status,
        moderator,
        spammer,
        reporter,
        resolvedAt,
      ];

  PostReport copyWith({
    Post? post,
    Id? reportId,
    ResolveStatus? status,
    BasicPublicProfile? moderator,
    BasicPublicProfile? spammer,
    BasicPublicProfile? reporter,
    String? resolvedAt,
  }) {
    return PostReport(
      post: post ?? this.post,
      moderator: moderator ?? this.moderator,
      spammer: spammer ?? this.spammer,
      reporter: reporter ?? this.reporter,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      reportId: reportId ?? this.reportId,
      status: status ?? this.status,
    );
  }
}
