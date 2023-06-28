import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/auth_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_follower_user.dart';
import 'package:picnic_app/core/data/graphql/model/gql_profile_stats.dart';
import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/graphql/model/gql_username_check_result.dart';
import 'package:picnic_app/core/data/graphql/users_queries.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/block_user_failure.dart';
import 'package:picnic_app/core/domain/model/check_username_availability_failure.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_by_username_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/search_users_failure.dart';
import 'package:picnic_app/core/domain/model/unblock_user_failure.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/search_non_member_users_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_followers_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import 'package:picnic_app/features/profile/domain/model/send_glitter_bomb_failure.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlUsersRepository with FutureRetarder implements UsersRepository {
  GraphqlUsersRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>> checkUsernameAvailability({
    required String username,
  }) {
    return _gqlClient
        .query(
      document: checkUsernameQuery,
      variables: {"username": username},
      parseData: (json) => GqlUsernameCheckResult.fromJson((json["checkUsername"] as Map).cast()),
    )
        .mapFailure((fail) {
      return CheckUsernameAvailabilityFailure.unknown(fail);
    }).mapSuccess((response) {
      return response.toDomain();
    });
  }

  @override
  Future<Either<GetUserFailure, PublicProfile>> getUser({required Id userId}) async {
    if (userId.isNone) {
      return left(const GetUserFailure.unknown("userId was null"));
    }
    return _gqlClient
        .query(
          document: getUserByIdQuery,
          variables: {"id": userId.value},
          parseData: (json) => GqlPublicProfile.fromJson(asT(json, 'user')),
        )
        .mapFailure((fail) => GetUserFailure.unknown(fail))
        .mapSuccess(
          (response) => response.toDomain(
            _userStore,
          ),
        );
  }

  @override
  Future<Either<GetUserByUsernameFailure, Id>> getUserId({required String username}) {
    return _gqlClient
        .query(
          document: getUserByUsernameQuery,
          variables: {"userName": username},
          parseData: (json) => asT<String>(json['profileGetUserIDByName'] as Map<String, dynamic>, 'userId'),
        )
        .mapFailure((fail) => GetUserByUsernameFailure.unknown(fail))
        .mapSuccess((response) => Id(response));
  }

  @override
  Future<Either<SearchUsersFailure, PaginatedList<PublicProfile>>> searchUser({
    required String searchQuery,
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: searchUsersQuery,
            variables: {
              'searchQuery': searchQuery,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['usersConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(SearchUsersFailure.unknown)
          .mapSuccess(
            (response) => response.toDomainWithRelations(
              nodeMapper: (node, relations) => GqlFollowerUser.fromJson(node, relations).toDomain(),
            ),
          );

  @override
  Future<Either<BlockUserFailure, Unit>> block({required Id userId}) => _gqlClient
      .mutate(
        document: changeBlockStatusMutation,
        variables: {
          'shouldBlock': true,
          'userId': userId.value,
        },
        parseData: (json) {
          return unit;
        },
      )
      .mapFailure(BlockUserFailure.unknown)
      .mapSuccess((result) => result);

  @override
  Future<Either<UnblockUserFailure, Unit>> unblock({required Id userId}) => _gqlClient
      .mutate(
        document: changeBlockStatusMutation,
        variables: {
          'shouldBlock': false,
          'userId': userId.value,
        },
        parseData: (json) {
          return unit;
        },
      )
      .mapFailure(UnblockUserFailure.unknown)
      .mapSuccess((result) => result);

  @override
  Future<Either<GetFollowersFailure, PaginatedList<PublicProfile>>> getFollowers({
    required Id userId,
    required String searchQuery,
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: getFollowersQuery,
            variables: {
              'id': userId.value,
              'searchQuery': searchQuery,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['followersConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure((fail) => GetFollowersFailure.unknown(fail))
          .mapSuccess(
            (response) => response.toDomainWithRelations(
              nodeMapper: (node, relations) => GqlFollowerUser.fromJson(node, relations).toDomain(),
            ),
          );

  @override
  Future<Either<FollowUnfollowUserFailure, Unit>> followUnFollowUser({
    required Id userId,
    required bool follow,
  }) =>
      _gqlClient
          .mutate(
            document: changeFollowStatusMutation,
            variables: {
              'shouldFollow': follow,
              'userId': userId.value,
            },
            parseData: (json) {
              return unit;
            },
          )
          .mapFailure(FollowUnfollowUserFailure.unknown)
          .mapSuccess((result) => result);

  @override
  Future<Either<SendGlitterBombFailure, Unit>> sendGlitterBomb({required Id userId}) => _gqlClient
      .mutate(
        document: glitterbombMutation,
        variables: {
          'userId': userId.value,
        },
        parseData: (json) {
          return unit;
        },
      )
      .mapFailure(SendGlitterBombFailure.unknown)
      .mapSuccess((result) => result);

  @override
  Future<Either<SearchNonMemberUsersFailure, PaginatedList<PublicProfile>>> searchNonMembershipUsers({
    required String searchQuery,
    required Id circleId,
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: getNonMemberUsersQuery,
            variables: {
              'searchQuery': searchQuery,
              'circleID': circleId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['searchUsersConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(SearchNonMemberUsersFailure.unknown)
          .mapSuccess(
            (connection) =>
                connection.toDomain(nodeMapper: (node) => GqlPublicProfile.fromJson(node).toDomain(_userStore)),
          );

  @override
  Future<Either<GetProfileStatsFailure, ProfileStats>> getProfileStats({required Id userId}) async {
    if (userId.isNone) {
      return failure(const GetProfileStatsFailure.unknown("userId was null"));
    }
    return _gqlClient
        .query(
          document: getProfileStatsQuery,
          variables: {'userID': userId.value},
          parseData: (json) => GqlProfileStats.fromJson(asT(json, 'contentStatsForProfile')),
        )
        .mapFailure((fail) => GetProfileStatsFailure.unknown(fail))
        .mapSuccess((result) => result.toDomain());
  }
}
