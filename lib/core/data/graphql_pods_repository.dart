import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/get_saved_apps_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_app.dart';
import 'package:picnic_app/core/data/graphql/model/gql_app_tag.dart';
import 'package:picnic_app/core/data/graphql/model/gql_generated_token.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/pods_queries.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/featured_pods_failure.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/core/domain/model/get_trending_pods_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_scoped_pod_token_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/model/search_pods_failure.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/model/get_pods_tags_failure.dart';
import 'package:picnic_app/features/pods/domain/model/get_saved_pods_failure.dart';
import 'package:picnic_app/features/pods/domain/model/save_pod_failure.dart';

class GraphqlPodsRepository implements PodsRepository {
  const GraphqlPodsRepository(this._gqlClient);

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetUserScopedPodTokenFailure, GeneratedToken>> getGeneratedAppToken({
    required Id podId,
  }) =>
      _gqlClient
          .mutate(
            document: getGeneratedAppTokenMutation,
            variables: {
              'appID': podId.value,
            },
            parseData: (json) {
              final data = json['generateUserScopedAppToken'] as Map<String, dynamic>;
              return GqlGeneratedToken.fromJson(data);
            },
          )
          .mapFailure(GetUserScopedPodTokenFailure.unknown)
          .mapSuccess((response) => response.toDomain());

  @override
  Future<Either<GetTrendingPodsFailure, PaginatedList<PodApp>>> getTrendingPods({Cursor? cursor}) async {
    return _gqlClient
        .query(
          document: getTrendingAppsQuery,
          variables: {
            if (cursor != null) 'cursor': cursor.toGqlCursorInput(),
          },
          parseData: (json) {
            final data = json['getTrendingApps'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(GetTrendingPodsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlApp.fromJson(node).toDomain(),
          ),
        );
  }

  @override
  Future<Either<GetPodsTagsFailure, List<AppTag>>> getPodsTags({required List<Id> podsIdsList}) => _gqlClient
      .mutate(
        document: getAppsTagsQuery,
        variables: {
          'ids': podsIdsList.map((ids) => ids.value).toList(),
        },
        parseData: (json) {
          return asList(
            json,
            'getAppTags',
            GqlAppTag.fromJson,
          );
        },
      )
      .mapFailure(GetPodsTagsFailure.unknown)
      .mapSuccess(
        (data) => data.map((e) => e.toDomain()).toList(growable: false),
      );

  @override
  Future<Either<SavePodFailure, Unit>> savePod({
    required Id podId,
  }) =>
      _gqlClient
          .mutate(
            document: savePodMutation,
            variables: {
              'appID': podId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['saveApp'] as Map<String, dynamic>),
          )
          .mapFailure(SavePodFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const SavePodFailure.unknown());

  @override
  Future<Either<GetSavedPodsFailure, PaginatedList<PodApp>>> getSavedPods({required Cursor nextPageCursor}) async {
    return _gqlClient
        .query(
          document: getSavedAppsQuery,
          variables: {
            'in': GetSavedAppsInput(cursor: nextPageCursor.toGqlCursorInput()).toJson(),
          },
          parseData: (json) {
            final data = json['getSavedApps'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(GetSavedPodsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlApp.fromJson(node).toDomain(),
          ),
        );
  }

  @override
  Future<Either<FeaturedPodsFailure, PaginatedList<PodApp>>> getFeaturedPods({required Cursor nextPageCursor}) async {
    return _gqlClient
        .query(
          document: getFeaturedApps,
          variables: {
            'cursor': nextPageCursor.toGqlCursorInput(),
          },
          parseData: (json) {
            final data = json['getFeaturedApps'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(FeaturedPodsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlApp.fromJson(node).toDomain(),
          ),
        );
  }

  @override
  Future<Either<SearchPodsFailure, PaginatedList<PodApp>>> searchPods({required SearchPodInput input}) async {
    return _gqlClient
        .query(
          document: searchAppsQuery,
          variables: {
            'cursor': input.cursor.toGqlCursorInput(),
            'nameStartsWith': input.nameStartsWith,
            'tagIds': input.tagIds.map((tagId) => tagId.value).toList(),
            'orderBy': input.orderBy.value,
          },
          parseData: (json) {
            final data = json['searchApps'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(SearchPodsFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlApp.fromJson(node).toDomain(),
          ),
        );
  }
}
