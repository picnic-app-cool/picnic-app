import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/circles/domain/model/comment_report.dart';
import 'package:picnic_app/features/circles/domain/model/message_report.dart';
import 'package:picnic_app/features/posts/domain/model/post_report.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';

abstract class ViolationReport {
  ReportEntityType get reportType;

  ResolveStatus get status;

  String get resolvedAt;

  BasicPublicProfile get moderator;

  BasicPublicProfile get spammer;

  BasicPublicProfile get reporter;
}

extension ReportEntityTypeSwitch on ViolationReport {
  /// convenience method that allows for exhaustive switching on different types of events
  /// with smart casting the type of event
  void when({
    Function(PostReport report)? newPostReportReceived,
    Function(MessageReport report)? newMessageReportReceived,
    Function(CommentReport report)? newCommentReportReceived,
    Function(ViolationReport report)? onOtherReportReceived,
  }) {
    switch (reportType) {
      case ReportEntityType.message:
        newMessageReportReceived?.call(this as MessageReport);
        return;
      case ReportEntityType.post:
        newPostReportReceived?.call(this as PostReport);
        return;
      case ReportEntityType.comment:
        newCommentReportReceived?.call(this as CommentReport);
        return;
      case ReportEntityType.circle:
      case ReportEntityType.chat:
      case ReportEntityType.user:
      case ReportEntityType.collection:
      case ReportEntityType.slice:
      case ReportEntityType.all:
      case ReportEntityType.spam:
      case ReportEntityType.text:
      case ReportEntityType.image:
      case ReportEntityType.video:
      case ReportEntityType.link:
      case ReportEntityType.poll:
      case ReportEntityType.unknown:
        onOtherReportReceived?.call(this);
        return;
    }
  }
}
