import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/circles_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/model/gql_violation_report.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_related_messages_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_reports_failure.dart';
import 'package:picnic_app/features/circles/domain/model/resolve_report_failure.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_reports_repository.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlCircleReportsRepository with FutureRetarder implements CircleReportsRepository {
  const GraphqlCircleReportsRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetReportsFailure, PaginatedList<ViolationReport>>> getReports({
    required Id circleId,
    required Cursor nextPageCursor,
    required CircleReportsFilterBy filterBy,
  }) async {
    return _gqlClient
        .query(
          document: getCircleReportsConnectionQuery,
          variables: {
            'circleId': circleId.value,
            'cursor': nextPageCursor.toGqlCursorInput(),
            'filterBy': filterBy.toJson(),
          },
          parseData: (json) => GqlConnection.fromJson(json['circleReportsConnection'] as Map<String, dynamic>),
        )
        .mapFailure(GetReportsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) {
              return GqlViolationReport.fromJson(node).toDomain(
                _userStore,
              );
            },
          ),
        );
  }

  @override
  Future<Either<ResolveReportFailure, Unit>> resolveReport({
    required Id reportId,
    required Id circleId,
    required bool resolve,
  }) {
    return _gqlClient
        .mutate(
          document: resolveReportMutation,
          variables: {
            'circleId': circleId.value,
            'reportId': reportId.value,
            'fullFill': resolve,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['resolveReport'] as Map<String, dynamic>),
        )
        .mapFailure(ResolveReportFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const ResolveReportFailure.unknown());
  }

  @override
  Future<Either<GetRelatedMessagesFailure, List<ChatMessage>>> getRelatedMessages({
    required Id messageId,
    required int relatedMessagesCount,
  }) async {
    return _gqlClient
        .query(
          document: getRelatedMessagesQuery,
          variables: {
            'messageId': messageId.value,
            'marginSize': relatedMessagesCount,
          },
          parseData: (json) {
            final data = json['getRelatedMessages'] as List;
            return data.map((e) => GqlChatMessageJson.fromJson(e as Map<String, dynamic>));
          },
        )
        .mapFailure(GetRelatedMessagesFailure.unknown)
        .mapSuccess(
          (connection) => connection.map((e) => e.toDomain()).toList(),
        );
  }
}
