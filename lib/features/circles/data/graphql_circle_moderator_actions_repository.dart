import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/circles_queries.dart';
import 'package:picnic_app/core/data/graphql/gql_word.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_edge.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_page_info.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/data/graphql/circle_config_queries.dart';
import 'package:picnic_app/features/circles/data/graphql/model/gql_create_circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/data/graphql/model/gql_create_circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/data/models/gql_circle_config_json.dart';
import 'package:picnic_app/features/circles/domain/model/add_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/ban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/domain/model/create_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_default_circle_config_failure.dart';
import 'package:picnic_app/features/circles/domain/model/remove_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/un_assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/unban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class GraphqlCircleModeratorActionsRepository implements CircleModeratorActionsRepository {
  const GraphqlCircleModeratorActionsRepository({required this.gqlClient});

  final GraphQLClient gqlClient;

  @override
  Future<Either<BanUserFailure, Id>> banUser({
    required Id circleId,
    required Id userId,
  }) {
    return gqlClient
        .mutate(
          document: banUserInCircleMutation,
          variables: {
            'circleId': circleId.value,
            'userId': userId.value,
          },
          parseData: (json) {
            final banUserCircle = json['banUserInCircle'] as Map<String, dynamic>;
            return Id(banUserCircle['userId'].toString());
          },
        )
        .mapFailure((fail) => const BanUserFailure.unknown());
  }

  @override
  Future<Either<UnbanUserFailure, Id>> unbanUser({
    required Id circleId,
    required Id userId,
  }) =>
      gqlClient
          .mutate(
            document: unbanUserInCircleMutation,
            variables: {
              'circleId': circleId.value,
              'userId': userId.value,
            },
            parseData: (json) {
              final unbanUserCircle = json['unbanUserInCircle'] as Map<String, dynamic>;
              return Id(unbanUserCircle['userId'].toString());
            },
          )
          .mapFailure((fail) => const UnbanUserFailure.unknown());

  @override
  Future<Either<AddBlacklistedWordsFailure, Unit>> addBlackListedWords({
    required Id circleId,
    required List<String> words,
  }) async {
    return gqlClient
        .mutate(
          document: addCustomBLWordsMutation,
          variables: {
            'circleId': circleId.value,
            'words': words,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(
            json['addCustomBLWords'] as Map<String, dynamic>,
          ),
        )
        .mapFailure(AddBlacklistedWordsFailure.unknown)
        .mapSuccessPayload(
          onFailureReturn: const AddBlacklistedWordsFailure.unknown(),
        );
  }

  @override
  Future<Either<GetBlacklistedWordsFailure, PaginatedList<String>>> getBlackListedWords({
    required Id circleId,
    required Cursor cursor,
    String? searchQuery,
  }) async {
    return gqlClient
        .mutate(
          document: blackListedWordsQuery,
          variables: {
            'circleId': circleId.value,
            'cursor': cursor.toGqlCursorInput(),
            'searchQuery': searchQuery,
          },
          parseData: (json) {
            final data = json['blwConnection'] as Map<String, dynamic>;
            return data;
          },
        )
        .mapFailure(GetBlacklistedWordsFailure.unknown)
        .mapSuccess((json) {
      final pageInfo = GqlPageInfo.fromJson(
        asT<Map<String, dynamic>>(json, 'pageInfo'),
      );
      final words = asList(
        json,
        'edges',
        GqlWord.fromJson,
      );
      return PaginatedList(
        pageInfo: pageInfo.toDomain(<GqlEdge>[]),
        items: words.map((word) => word.toDomain()).toList(),
      );
    });
  }

  @override
  Future<Either<RemoveBlacklistedWordsFailure, Unit>> removeBlacklistedWords({
    required Id circleId,
    required List<String> words,
  }) =>
      gqlClient
          .mutate(
            document: removeCustomBLWordsMutation,
            variables: {
              'circleId': circleId.value,
              'words': words,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(
              json['removeCustomBLWords'] as Map<String, dynamic>,
            ),
          )
          .mapFailure(RemoveBlacklistedWordsFailure.unknown)
          .mapSuccessPayload(
            onFailureReturn: const RemoveBlacklistedWordsFailure.unknown(),
          );

  @override
  Future<Either<CreateCircleRoleFailure, Id>> createCircleRole({
    required CircleCustomRoleInput circleCustomRoleInput,
  }) async {
    return gqlClient
        .mutate(
          document: createCircleCustomRoleMutation,
          variables: {
            "createCircleCustomRoleInput": circleCustomRoleInput.toJson(),
          },
          parseData: (json) {
            final data = json['createCircleCustomRole'] as Map<String, dynamic>;
            return Id(data['roleId'].toString());
          },
        )
        .mapFailure(CreateCircleRoleFailure.unknown);
  }

  @override
  Future<Either<UpdateCircleRoleFailure, Id>> updateCircleRole({
    required CircleCustomRoleUpdateInput circleCustomRoleUpdateInput,
  }) async {
    return gqlClient
        .mutate(
          document: updateCircleCustomRoleMutation,
          variables: {
            "updateCircleCustomRoleInput": circleCustomRoleUpdateInput.toJson(),
          },
          parseData: (json) {
            final data = json['updateCircleCustomRole'] as Map<String, dynamic>;
            return Id(data['roleId'].toString());
          },
        )
        .mapFailure(UpdateCircleRoleFailure.unknown);
  }

  @override
  Future<Either<AssignUserRoleFailure, Unit>> assignRole({
    required Id circleId,
    required Id userId,
    required Id roleId,
  }) {
    return gqlClient
        .mutate(
          document: assignUserRoleMutation,
          variables: {
            'circleId': circleId.value,
            'userId': userId.value,
            'roleId': roleId.value,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(
            json['addCustomRoleToUserInCircle'] as Map<String, dynamic>,
          ),
        )
        .mapFailure(AssignUserRoleFailure.unknown)
        .mapSuccessPayload(
          onFailureReturn: const AssignUserRoleFailure.unknown(),
        );
  }

  @override
  Future<Either<UnAssignUserRoleFailure, Unit>> unAssignRole({
    required Id circleId,
    required Id userId,
    required Id roleId,
  }) {
    return gqlClient
        .mutate(
          document: unAssignUserRoleMutation,
          variables: {
            'circleId': circleId.value,
            'userId': userId.value,
            'roleId': roleId.value,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(
            json['deleteCustomRoleFromUserInCircle'] as Map<String, dynamic>,
          ),
        )
        .mapFailure(UnAssignUserRoleFailure.unknown)
        .mapSuccessPayload(
          onFailureReturn: const UnAssignUserRoleFailure.unknown(),
        );
  }

  @override
  Future<Either<GetDefaultCircleConfigFailure, List<CircleConfig>>> getDefaultCircleConfig() => gqlClient
      .query(
        document: getDefaultCircleConfigQuery,
        parseData: (json) {
          final data = json['defaultCircleConfigOptions'] as Map<String, dynamic>;
          final list = data['options'] as List;
          return list.map((e) => GqlCircleConfigJson.fromJson(e as Map<String, dynamic>).toDomain()).toList();
        },
      )
      .mapFailure((fail) => const GetDefaultCircleConfigFailure.unknown());
}
