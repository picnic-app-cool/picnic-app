import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_slice.dart';
import 'package:picnic_app/core/data/graphql/model/gql_slice_member.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/slice_queries.dart';
import 'package:picnic_app/core/data/graphql/slices_queries.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_slice_members_failure.dart';
import 'package:picnic_app/core/domain/model/get_slices_failure.dart';
import 'package:picnic_app/core/domain/model/join_slice_failure.dart';
import 'package:picnic_app/core/domain/model/leave_slice_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/core/domain/model/update_slice_failure.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/features/slices/data/model/gql_accept_request_input.dart';
import 'package:picnic_app/features/slices/data/model/gql_update_slice_input.dart';
import 'package:picnic_app/features/slices/domain/model/accept_request_input.dart';
import 'package:picnic_app/features/slices/domain/model/approve_join_request_failure.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlSlicesRepository with FutureRetarder implements SlicesRepository {
  const GraphqlSlicesRepository(
    this._gqlClient,
    this._userStore,
  );

  //TODO (GS-5363): remove once merged with create slice: https://picnic-app.atlassian.net/browse/GS-5363
  static const testId = "4fa19828-f768-4a64-82bf-019a69cbe3ec";

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetSlicesFailure, PaginatedList<Slice>>> getSlices({
    required Id circleId,
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: getSlicesQuery,
            variables: {
              'circleId': circleId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['slicesConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetSlicesFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlSlice.fromJson(node).toDomain()),
          );

  @override
  Future<Either<ApproveJoinRequestFailure, Slice>> approveJoinRequest({required AcceptRequestInput requestInput}) =>
      _gqlClient
          .mutate(
            document: approveJoinRequestMutation,
            variables: {
              'acceptRequestInput': requestInput.toJson(),
            },
            parseData: (json) {
              return GqlSlice.fromJson(json).toDomain();
            },
          )
          .mapFailure(ApproveJoinRequestFailure.unknown);

  @override
  Future<Either<GetSliceMembersFailure, PaginatedList<SliceMember>>> getSliceMembers({
    required Id sliceId,
    required Cursor cursor,
    required List<SliceRole> roles,
    String? searchQuery,
  }) =>
      _gqlClient
          .query(
            document: getSliceMembersQuery,
            variables: {
              'sliceId': sliceId.value,
              'cursor': cursor.toGqlCursorInput(),
              'roles': roles,
              'searchQuery': searchQuery,
            },
            parseData: (json) {
              final data = json['slicesMembersConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetSliceMembersFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlSliceMember.fromJson(node).toDomain(_userStore),
            ),
          );

  @override
  Future<Either<UpdateSliceFailure, Slice>> updateSlice({
    required Id sliceId,
    required SliceUpdateInput input,
  }) {
    return _gqlClient.mutate(
      document: updateSliceMutation,
      parseData: (json) {
        return GqlSlice.fromJson(json['updateSlice'] as Map<String, dynamic>).toDomain();
      },
      variables: {
        'sliceId': sliceId.value,
        //TODO https://picnic-app.atlassian.net/browse/GS-5904
        'payload': input.copyWith(image: '').toJson(),
      },
    ).mapFailure(UpdateSliceFailure.unknown);
  }

  @override
  Future<Either<JoinSliceFailure, Unit>> joinSlice({
    required Id sliceId,
  }) =>
      _gqlClient
          .mutate(
            document: joinSliceMutation,
            variables: {
              'sliceId': sliceId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(
              json['joinSlices'] as Map<String, dynamic>,
            ),
          )
          .mapFailure(JoinSliceFailure.unknown)
          .mapSuccessPayload(
            onFailureReturn: const JoinSliceFailure.unknown(),
          );

  @override
  Future<Either<LeaveSliceFailure, Unit>> leaveSlice({required Id sliceId}) => _gqlClient
      .mutate(
        document: leaveSliceMutation,
        variables: {
          'sliceId': sliceId.value,
        },
        parseData: (json) => GqlSuccessPayload.fromJson(
          json['leaveSlices'] as Map<String, dynamic>,
        ),
      )
      .mapFailure(LeaveSliceFailure.unknown)
      .mapSuccessPayload(
        onFailureReturn: const LeaveSliceFailure.unknown(),
      );
}
