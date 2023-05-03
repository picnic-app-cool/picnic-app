import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/data/graphql/circle_posts_queries.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_sorted_posts_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_sorting_option_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_posts_repository.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GraphqlCirclePostsRepository implements CirclePostsRepository {
  const GraphqlCirclePostsRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetCircleSortedPostsFailure, PaginatedList<Post>>> getCircleSortedPosts({
    required Id circleId,
    required Cursor nextPageCursor,
    required PostsSortingType sortingType,
  }) =>
      _gqlClient
          .query(
            document: getCircleSortedPostsQuery,
            variables: {
              'circleId': circleId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
              'sortingType': sortingType.toJson(),
            },
            parseData: (json) {
              final data = json['sortedCirclePostsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetCircleSortedPostsFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlPost.fromJson(node).toDomain(_userStore),
            ),
          );

  @override
  Future<Either<GetLastUsedSortingOptionFailure, PostsSortingType>> getLastUsedSortingOption({
    required Id circleId,
  }) {
    return _gqlClient
        .query(
          document: getLastUsedSortingOptionQuery,
          variables: {
            'circleId': circleId.value,
          },
          parseData: (json) {
            return asT<String>(json, 'postsSortingType');
          },
        )
        .mapFailure(GetLastUsedSortingOptionFailure.unknown)
        .mapSuccess(
          (postsSortingType) => PostsSortingType.fromString(postsSortingType),
        );
  }
}
