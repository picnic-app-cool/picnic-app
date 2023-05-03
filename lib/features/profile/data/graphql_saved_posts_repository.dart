import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/data/profile_queries.dart';
import 'package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/repositories/saved_posts_repository.dart';

class GraphqlSavedPostsRepository implements SavedPostsRepository {
  const GraphqlSavedPostsRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetSavedPostsFailure, PaginatedList<Post>>> getSavedPosts({
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: getSavedPostsQuery,
            variables: {
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['savedPostsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetSavedPostsFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              ///TODO create `PostListItem` domain entity to differentiate from the full `Post` object,
              ///TODO since we're not querying the full post object here
              nodeMapper: (node) => GqlPost.fromJson(node).toDomain(
                _userStore,
              ),
            ),
          );
}
