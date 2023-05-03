import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/data/graphql/user_posts_queries.dart';
import 'package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/repositories/get_user_posts_repository.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlGetUserPostsRepository with FutureRetarder implements GetUserPostsRepository {
  const GraphqlGetUserPostsRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<GetUserPostsFailure, PaginatedList<Post>>> getUserPosts({
    required Id userId,
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: getUserPostsQuery,
            variables: {
              'userId': userId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['userPostsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetUserPostsFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlPost.fromJson(node).toDomain(
                _userStore,
              ),
            ),
          );
}
