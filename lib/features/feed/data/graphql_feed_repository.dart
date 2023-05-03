import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/feed/data/feed_queries.dart';
import 'package:picnic_app/features/feed/data/model/gql_feed_json.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/domain/model/get_popular_feed_failure.dart';
import 'package:picnic_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GraphQlFeedRepository implements FeedRepository {
  GraphQlFeedRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Stream<CacheableResult<GetFeedsListFailure, PaginatedList<Feed>>> getFeeds({
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .watchQuery(
        document: getFeedsQuery,
        variables: {'cursor': nextPageCursor.toGqlCursorInput().toJson()},
        parseData: (json) {
          final data = json['feedsConnection'] as Map<String, dynamic>;
          return GqlConnection.fromJson(data);
        },
        options: const WatchQueryOptions.defaultOptions(),
      )
          .mapFailure((fail) {
        return GetFeedsListFailure.unknown(fail);
      }).mapSuccess(
        (connection) {
          return connection.toDomain(nodeMapper: (node) => GqlFeedJson.fromJson(node).toDomain());
        },
      );

  @override
  Future<Either<GetPopularFeedFailure, PaginatedList<Post>>> getPopularFeedPosts() {
    return _gqlClient
        .query(
          document: getPopularFeedPostsQuery,
          variables: {'cursor': const Cursor.firstPage().toGqlCursorInput().toJson()},
          parseData: (json) {
            final data = asT<Map<String, dynamic>>(json, 'popularFeed');
            final posts = asT<Map<String, dynamic>>(data, 'posts');
            return GqlConnection.fromJson(posts);
          },
        )
        .mapFailure(GetPopularFeedFailure.unknown)
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlPost.fromJson(node).toDomain(
              _userStore,
            ),
          ),
        );
  }
}
