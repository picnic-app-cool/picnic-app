import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/circles_queries.dart';
import 'package:picnic_app/core/data/graphql/gql_list_groups_input.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_edge.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_page_info.dart';
import 'package:picnic_app/core/data/graphql/model/gql_basic_circle.dart';
import 'package:picnic_app/core/data/graphql/model/gql_circle.dart';
import 'package:picnic_app/core/data/graphql/model/gql_circle_app.dart';
import 'package:picnic_app/core/data/graphql/model/gql_circle_stats.dart';
import 'package:picnic_app/core/data/graphql/model/gql_election_candidate.dart';
import 'package:picnic_app/core/data/graphql/model/gql_get_user_circles_request.dart';
import 'package:picnic_app/core/data/graphql/model/gql_group.dart';
import 'package:picnic_app/core/data/graphql/model/gql_onboarding_circles_section.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_circle_by_name_failure.dart';
import 'package:picnic_app/core/domain/model/get_circle_stats_failure.dart';
import 'package:picnic_app/core/domain/model/get_circles_failure.dart';
import 'package:picnic_app/core/domain/model/get_members_input.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/leave_circle_failure.dart';
import 'package:picnic_app/core/domain/model/onboarding_circles_section.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/update_circle_failure.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/data/model/gql_invite_users_to_circle_input.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/data/graphql/circle_roles_queries.dart';
import 'package:picnic_app/features/circles/data/graphql/model/gql_circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/delete_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_banned_users_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_details_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_by_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_roles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_groups_of_circles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_onboarding_circles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_pods_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_user_roles_in_circle_failure.dart';
import 'package:picnic_app/features/circles/domain/model/invite_user_to_circle_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_member_role_failure.dart';
import 'package:picnic_app/features/create_circle/data/model/gql_create_circle_input.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';

class GraphqlCirclesRepository implements CirclesRepository {
  const GraphqlCirclesRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  //TODO: BE - search query and pagination needed for getCircleCustomRoles : https://picnic-app.atlassian.net/browse/GS-7309
  @override
  Future<Either<GetCircleRolesFailure, PaginatedList<CircleCustomRole>>> getCircleRoles({
    required Id circleId,
  }) =>
      _gqlClient
          .query(
            document: getCircleCustomRoles,
            variables: {
              'circleId': circleId.value,
            },
            parseData: (json) {
              final data = json['getCircleCustomRoles'] as Map<String, dynamic>;
              return data;
            },
          )
          .mapFailure(GetCircleRolesFailure.unknown)
          .mapSuccess((json) {
        final pageInfo = GqlPageInfo.fromJson(
          asT<Map<String, dynamic>>(json, 'pageInfo'),
        );
        final roles = asList(
          json,
          'edges',
          GqlCircleCustomRole.fromJson,
        );
        return PaginatedList(
          pageInfo: pageInfo.toDomain(<GqlEdge>[]),
          items: roles.map((role) => role.toDomain()).toList(),
        );
      });

  @override
  Future<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>> getUserRolesInCircle({
    required Id circleId,
    required Id userId,
  }) =>
      _gqlClient
          .query(
            document: getUserRolesInCircleQuery,
            variables: {
              'circleId': circleId.value,
              'userId': userId.value,
            },
            parseData: (json) {
              final data = json['getCircleMemberCustomRoles'] as Map<String, dynamic>;
              return data;
            },
          )
          .mapFailure(GetUserRolesInCircleFailure.unknown)
          .mapSuccess((json) {
        final assignedRoles = _mapGqlRolesList(json, 'roles');
        final unassignedRoles = _mapGqlRolesList(json, 'unassigned');
        final mainRoleId = asT<String>(json, 'mainRoleId');
        return CircleMemberCustomRoles(
          roles: assignedRoles.map((role) => role.toDomain()).toList(),
          unassigned: unassignedRoles.map((role) => role.toDomain()).toList(),
          mainRoleId: mainRoleId,
        );
      });

  @override
  Future<Either<DeleteRoleFailure, Unit>> deleteCircleRole({
    required Id roleId,
    required Id circleId,
  }) async {
    return _gqlClient
        .mutate(
          document: deleteCircleCustomRole,
          variables: {
            'roleId': roleId.value,
            'circleId': circleId.value,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(
            json['deleteCircleCustomRole'] as Map<String, dynamic>,
          ),
        )
        .mapFailure(DeleteRoleFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const DeleteRoleFailure.unknown());
  }

  @override
  Future<Either<GetCirclesFailure, PaginatedList<Circle>>> getCircles({
    String? searchQuery,
    Cursor? nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: getCirclesQuery,
            variables: {
              'searchQuery': searchQuery,
              'cursor': nextPageCursor?.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['circlesConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetCirclesFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlCircle.fromJson(node).toDomain()),
          );

  @override
  Future<Either<GetCircleByNameFailure, PaginatedList<Circle>>> getCircle({String? searchQuery}) {
    return _gqlClient
        .query(
          document: getCircleNameByIdQuery,
          variables: {
            'searchQuery': searchQuery,
            'isStrict': true,
          },
          parseData: (json) {
            final data = json['circlesConnection'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(GetCircleByNameFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(nodeMapper: (node) => GqlCircle.fromJson(node).toDomain()),
        );
  }

  @override
  Future<Either<GetUserCirclesFailure, PaginatedList<Circle>>> getUserCircles({
    required Cursor nextPageCursor,
    List<CircleRole>? roles,
    String? searchQuery,
    Id? userId,
  }) =>
      _gqlClient
          .query(
            document: getUserCirclesQuery,
            variables: {
              'getUserCircles': GqlGetUserCirclesRequest(
                cursor: nextPageCursor.toGqlCursorInput(),
                roles: roles,
                searchQuery: searchQuery,
                userId: userId,
              ),
            },
            parseData: (json) {
              final data = json['getUserCircles'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure((fail) => const GetUserCirclesFailure.unknown())
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlCircle.fromJson(node).toDomain()),
          );

  @override
  Future<Either<JoinCircleFailure, Unit>> joinCircle({
    required Id circleId,
  }) =>
      _joinCircles(circleIds: [circleId]);

  @override
  Future<Either<JoinCircleFailure, Unit>> joinCircles({
    required List<Id> circleIds,
  }) =>
      _joinCircles(circleIds: circleIds);

  @override
  Future<Either<LeaveCircleFailure, Unit>> leaveCircle({
    required Id circleId,
  }) =>
      _gqlClient
          .mutate(
            document: leaveCirclesMutation,
            variables: {
              'circleIds': [circleId.value],
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['leaveCircles'] as Map<String, dynamic>),
          )
          .mapFailure(LeaveCircleFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const LeaveCircleFailure.unknown());

  @override
  Future<Either<GetCircleDetailsFailure, Circle>> getCircleDetails({required Id circleId}) async => _gqlClient
      .query(
        document: getCircleByIdQuery,
        variables: {
          'circleId': circleId.value,
        },
        parseData: (json) {
          final data = json['getCircleById'] as Map<String, dynamic>;
          return GqlCircle.fromJson(data);
        },
      )
      .mapFailure((fail) => const GetCircleDetailsFailure.unknown())
      .mapSuccess((circle) => circle.toDomain());

  @override
  Future<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>> getCircleMembers({
    required Id circleId,
    required Cursor cursor,
    required String searchQuery,
  }) async =>
      _getMembersInCircle(
        GetMembersInput(
          circleId: circleId,
          cursor: cursor,
          searchQuery: searchQuery,
        ),
      ).mapSuccess(
        (electionCandidateList) =>
            electionCandidateList.mapItems((electionCandidate) => electionCandidate.publicProfile),
      );

  @override
  Future<Either<GetBannedUsersFailure, PaginatedList<ElectionCandidate>>> getBannedCircleMembers({
    required Id circleId,
    required Cursor cursor,
  }) async =>
      _getMembersInCircle(
        GetMembersInput(
          circleId: circleId,
          cursor: cursor,
          roles: const [
            CircleRole.moderator,
            CircleRole.member,
          ],
          onlyBannedUsers: true,
        ),
      ).mapFailure(
        (failure) => GetBannedUsersFailure(
          cause: failure.cause,
          type: GetBannedUsersFailureType.unknown,
        ),
      );

  @override
  Future<Either<GetCircleMembersByRoleFailure, PaginatedList<ElectionCandidate>>> getCircleMembersByRole({
    required Id circleId,
    required Cursor cursor,
    required List<CircleRole> roles,
    required String searchQuery,
  }) async =>
      _getMembersInCircle(
        GetMembersInput(
          circleId: circleId,
          cursor: cursor,
          roles: roles,
          searchQuery: searchQuery,
        ),
      ).mapFailure(
        (failure) => GetCircleMembersByRoleFailure(
          cause: failure.cause,
          type: GetGetModeratorsFailureType.unknown,
        ),
      );

  @override
  Future<Either<UpdateCircleFailure, Circle>> updateCircle({
    required UpdateCircleInput input,
  }) {
    return _gqlClient.mutate(
      document: updateCircleMutation,
      parseData: (json) {
        return GqlCircle.fromJson(json['updateCircle'] as Map<String, dynamic>).toDomain();
      },
      variables: {
        'circleId': input.circleId.value,
        'circleInput': input.circleUpdate.toJson(),
      },
    ).mapFailure(UpdateCircleFailure.unknown);
  }

  @override
  Future<Either<InviteUserToCircleFailure, Circle>> inviteUserToCircle({
    required InviteUsersToCircleInput input,
  }) {
    return _gqlClient
        .mutate(
          document: inviteUsersToCircleMutation,
          variables: {
            'inviteToCircleInput': GqlInviteUsersToCircleInput.fromDomain(input).toJson(),
          },
          parseData: (json) {
            final data = json['inviteUsersToCircle'] as Map<String, dynamic>;
            return GqlCircle.fromJson(data);
          },
        )
        .mapFailure(InviteUserToCircleFailure.unknown)
        .mapSuccess((circle) => circle.toDomain());
  }

  @override
  Future<Either<UpdateCircleMemberRoleFailure, Unit>> updateCircleMemberRole({
    required Id circleId,
    required CircleRole role,
    required Id userId,
    required bool isModPermissionEnabled,
  }) {
    return _gqlClient
        .mutate(
          document: updateCircleMemberRoleMutation,
          parseData: (json) => GqlSuccessPayload.fromJson(json['setUsersRoleInCircle'] as Map<String, dynamic>),
          variables: {
            'circleId': circleId.value,
            'userId': userId.value,
            'role': role,
            'isModPermissionEnabled': isModPermissionEnabled,
          },
        )
        .mapFailure(UpdateCircleMemberRoleFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const UpdateCircleMemberRoleFailure.unknown());
  }

  @override
  Future<Either<GetGroupsOfCirclesFailure, List<GroupWithCircles>>> getGroupsOfCircles({
    required ListGroupsInput listGroupsInput,
  }) =>
      _gqlClient
          .query(
            document: listGroupsQuery,
            variables: {
              'listGroupsRequest': listGroupsInput.toJson(),
            },
            parseData: (json) {
              final data = json['listGroups'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetGroupsOfCirclesFailure.unknown)
          .mapSuccess(
            (connection) => connection
                .toDomain(
                  nodeMapper: (node) => GqlGroup.fromJson(node).toDomain(),
                )
                .items,
          );

  @override
  //ignore: long-method
  Future<Either<GetOnBoardingCirclesFailure, List<OnboardingCirclesSection>>> getOnBoardingCircles() => _gqlClient
      .query(
        document: onBoardingCirclesConnectionQuery,
        parseData: (json) {
          final data = json['onBoardingCirclesConnection'] as Map<String, dynamic>;
          return asList(
            data,
            "edges",
            (data) => GqlOnboardingCirclesSection.fromJson(data),
          );
        },
      )
      .mapFailure(GetOnBoardingCirclesFailure.unknown)
      .mapSuccess(
        (data) => data.map((e) => e.toDomain()).toList(growable: false),
      );

  @override
  Future<Either<GetPodsFailure, PaginatedList<CirclePodApp>>> getPods({
    required Id circleId,
    required Cursor cursor,
  }) =>
      _gqlClient
          .query(
            document: getCirclePods,
            variables: {
              'cursor': cursor.toGqlCursorInput(),
              'circleId': circleId.value,
            },
            parseData: (json) {
              final data = json['circleApps'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetPodsFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlCircleApp.fromJson(node).toDomain()),
          );

  @override
  Future<Either<GetCircleStatsFailure, CircleStats>> getCircleStats({required Id circleId}) {
    return _gqlClient
        .query(
          document: getCircleStatsQuery,
          variables: {'circleID': circleId.value},
          parseData: (json) => GqlCircleStats.fromJson(asT(json, 'contentStatsForCircle')),
        )
        .mapFailure((fail) => GetCircleStatsFailure.unknown(fail))
        .mapSuccess((result) => result.toDomain());
  }

  @override
  Future<Either<GetCircleDetailsFailure, BasicCircle>> getBasicCircle({
    required Id circleId,
  }) =>
      _gqlClient
          .query(
            document: getBasicCircleByIdQuery,
            variables: {
              'circleId': circleId.value,
            },
            parseData: (json) {
              final data = json['getCircleById'] as Map<String, dynamic>;
              return GqlBasicCircle.fromJson(data);
            },
          )
          .mapFailure((fail) => const GetCircleDetailsFailure.unknown())
          .mapSuccess((circle) => circle.toDomain());

  Future<Either<JoinCircleFailure, Unit>> _joinCircles({
    required List<Id> circleIds,
  }) =>
      _gqlClient
          .mutate(
            document: joinCirclesMutation,
            variables: {
              'circleIds': circleIds.map((ids) => ids.value).toList(),
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['joinCircles'] as Map<String, dynamic>),
          )
          .mapFailure(JoinCircleFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const JoinCircleFailure.unknown());

  Future<Either<GetCircleMembersFailure, PaginatedList<ElectionCandidate>>> _getMembersInCircle(
    GetMembersInput getMembersInput,
  ) =>
      _gqlClient
          .query(
            document: getCircleMembersQuery,
            variables: {
              'circleId': getMembersInput.circleId.value,
              'cursor': getMembersInput.cursor.toGqlCursorInput(),
              'isBanned': getMembersInput.onlyBannedUsers,
              'roles': getMembersInput.roles,
              'searchQuery': getMembersInput.searchQuery,
            },
            parseData: (json) {
              final data = json['getMembers'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetCircleMembersFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlElectionCandidate.fromJson(node).toDomain(_userStore),
            ),
          );

  List<GqlCircleCustomRole> _mapGqlRolesList(Map<String, dynamic> json, String key) => asList(
        json,
        key,
        GqlCircleCustomRole.fromJson,
      );
}
