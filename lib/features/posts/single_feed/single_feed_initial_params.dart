import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart';
import 'package:picnic_app/features/posts/single_feed/sorting_handler.dart';

class SingleFeedInitialParams {
  SingleFeedInitialParams({
    required this.preloadedPosts,
    required this.initialIndex,
    required this.loadMore,
    required this.refresh,
    required this.onPostsListUpdated,
    SortingHandler? sortingHandler,
  }) : sortingHandler = sortingHandler ?? SortingHandler.noSorting();

  SingleFeedInitialParams.noPagination({
    required List<Post> posts,
    required this.initialIndex,
    required void Function(List<Post>) onPostsListUpdated,
    required Future<Either<DisplayableFailure, List<Post>>> Function() refresh,
  })  : preloadedPosts = PaginatedList.singlePage(posts),
        loadMore = (() => Future.value(success(const PaginatedList.singlePage()))),
        refresh = (() => refresh().mapSuccess((p) => PaginatedList.singlePage(p))),
        sortingHandler = SortingHandler.noSorting(),
        onPostsListUpdated = ((p) => onPostsListUpdated(p));

  final PaginatedList<Post> preloadedPosts;
  final int initialIndex;
  final LoadMoreCallback loadMore;
  final RefreshCallback refresh;
  final OnPostsListUpdatedCallback onPostsListUpdated;

  // when specified, displays sorting dropdown on top of the feed.
  // all sorting handling is done trough it
  final SortingHandler sortingHandler;
}
