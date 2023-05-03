import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/domain/repositories/feed_repository.dart';

class GetFeedsListUseCase {
  const GetFeedsListUseCase(this._feedRepository);

  final FeedRepository _feedRepository;

  Stream<CacheableResult<GetFeedsListFailure, PaginatedList<Feed>>> execute({
    required Cursor nextPageCursor,
  }) {
    return _feedRepository.getFeeds(nextPageCursor: nextPageCursor);
  }
}
