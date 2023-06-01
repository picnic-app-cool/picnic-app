import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_app.dart';
import 'package:picnic_app/core/data/graphql/model/gql_generated_token.dart';
import 'package:picnic_app/core/data/graphql/pods_queries.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
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
  Future<Either<SearchPodsFailure, PaginatedList<PodApp>>> searchPods({required SearchPodInput input}) async {
    return _gqlClient
        .query(
          document: searchAppsQuery,
          variables: {
            'cursor': input.cursor.toGqlCursorInput(),
            'nameStartsWith': input.nameStartsWith,
            'tagIds': input.tagIds,
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
