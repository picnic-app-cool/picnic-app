import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_related_messages_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_reports_failure.dart';
import 'package:picnic_app/features/circles/domain/model/resolve_report_failure.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';

abstract class CircleReportsRepository {
  Future<Either<GetReportsFailure, PaginatedList<ViolationReport>>> getReports({
    required Id circleId,
    required Cursor nextPageCursor,
    required CircleReportsFilterBy filterBy,
  });

  Future<Either<ResolveReportFailure, Unit>> resolveReport({
    required Id reportId,
    required Id circleId,
    required bool resolve,
  });

  Future<Either<GetRelatedMessagesFailure, List<ChatMessage>>> getRelatedMessages({
    required Id messageId,
    required int relatedMessagesCount,
  });
}
