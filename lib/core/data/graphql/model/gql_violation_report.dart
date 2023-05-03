import 'package:picnic_app/core/data/graphql/model/gql_basic_public_profile.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/comment_report.dart';
import 'package:picnic_app/features/circles/domain/model/message_report.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/posts/domain/model/post_report.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/unknown_report.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

class GqlViolationReport {
  const GqlViolationReport({
    required this.reportId,
    required this.userId,
    required this.circleId,
    required this.comment,
    required this.reportType,
    required this.contentAuthor,
    required this.reporter,
    required this.anyId,
    required this.status,
    required this.resolvedAt,
    required this.moderator,
  });

  factory GqlViolationReport.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlViolationReport(
      reportType: ReportEntityType.fromString(asT(json, 'reportType')),
      reportId: Id(asT(json, 'reportId')),
      userId: Id(asT(json, 'userId')),
      circleId: Id(asT(json, 'circleId')),
      comment: asT(json, 'comment'),
      moderator: GqlBasicPublicProfile.fromJson(
        asT(json, 'moderator'),
      ),
      resolvedAt: asT(json, 'resolvedAt'),
      anyId: Id(
        asT(json, 'anyId'),
      ),
      contentAuthor: GqlBasicPublicProfile.fromJson(
        asT(json, 'contentAuthor'),
      ),
      reporter: GqlBasicPublicProfile.fromJson(
        asT(json, 'reporter'),
      ),
      status: ResolveStatus.fromString(asT(json, 'status')),
    );
  }

  final ReportEntityType reportType;
  final Id userId;
  final Id circleId;
  final String comment;
  final Id reportId;
  final Id anyId;
  final GqlBasicPublicProfile contentAuthor;
  final GqlBasicPublicProfile reporter;
  final ResolveStatus status;
  final GqlBasicPublicProfile moderator;
  final String resolvedAt;

  //TODO Move more fields to ViolationReport, these look too similar GS-4401
  ViolationReport toDomain(UserStore userStore) {
    switch (reportType) {
      case ReportEntityType.message:
        return _getMessageReport(userStore);
      case ReportEntityType.post:
        return _getPostReport(userStore);
      case ReportEntityType.comment:
        return _getCommentReport(userStore);
      default:
        return const UnknownReport.empty();
    }
  }

  ViolationReport _getCommentReport(UserStore userStore) => CommentReport(
        resolvedAt: resolvedAt,
        moderator: moderator.toDomain(userStore),
        reportId: reportId,
        commentId: anyId,
        spammer: contentAuthor.toDomain(userStore),
        reporter: reporter.toDomain(userStore),
        status: status,
      );

  PostReport _getPostReport(UserStore userStore) => PostReport(
        moderator: moderator.toDomain(userStore),
        resolvedAt: resolvedAt,
        reporter: reporter.toDomain(userStore),
        spammer: contentAuthor.toDomain(userStore),
        reportId: reportId,
        post: const Post.empty().copyWith(
          id: anyId,
          author: contentAuthor.toDomain(userStore),
        ),
        status: status,
      );

  MessageReport _getMessageReport(UserStore userStore) => MessageReport(
        resolvedAt: resolvedAt,
        moderator: moderator.toDomain(userStore),
        reportId: reportId,
        messageId: anyId,
        spammer: contentAuthor.toDomain(userStore),
        reporter: reporter.toDomain(userStore),
        status: status,
      );
}
