import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/domain/model/get_popular_feed_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

abstract class FeedRepository {
  Stream<CacheableResult<GetFeedsListFailure, PaginatedList<Feed>>> getFeeds({
    required Cursor nextPageCursor,
  });

  Future<Either<GetPopularFeedFailure, PaginatedList<Post>>> getPopularFeedPosts();
}
