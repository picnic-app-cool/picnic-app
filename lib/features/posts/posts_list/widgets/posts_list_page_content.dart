import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/no_posts_card.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posts_list_vertical_page_view.dart';
import 'package:picnic_app/features/posts/widgets/post_grid_item.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_staggered_grid_view.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PostsListPageContent extends StatelessWidget {
  const PostsListPageContent({
    super.key,
    required this.refreshIndicatorKey,
    required this.isLoading,
    required this.isGridView,
    required this.posts,
    required this.onTapAuthor,
    required this.onTapCreatePost,
    required this.loadMore,
    required this.onPostUpdated,
    required this.onLongPress,
    required this.postDidAppear,
    required this.scrollController,
    required this.onRefresh,
    required this.showTimestamps,
  }) : assert(
          isGridView || scrollController is PageController,
          "when isGridView = false, scrollController must be PageController",
        );

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final bool isLoading;
  final bool isGridView;
  final PaginatedList<Post> posts;
  final void Function(Id) onTapAuthor;
  final void Function() onTapCreatePost;
  final Future<void> Function() loadMore;
  final void Function(Post) onPostUpdated;
  final void Function(Post) onLongPress;
  final void Function(Post) postDidAppear;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final bool showTimestamps;

  @override
  Widget build(BuildContext context) {
    const refreshIndicatorOffset = Constants.postInFeedNavBarGapHeight + 30;
    Widget content;
    if (isLoading) {
      content = const Center(
        child: PicnicLoadingIndicator(),
      );
    } else if (isGridView) {
      content = RefreshIndicator(
        key: refreshIndicatorKey,
        edgeOffset: refreshIndicatorOffset,
        onRefresh: onRefresh,
        child: PicnicPagingStaggeredGridView<Post>(
          controller: scrollController,
          paginatedList: posts,
          loadMore: loadMore,
          itemBuilder: (context, post) => PostGridItem(
            post: post,
            onTapAuthor: () => onTapAuthor(post.author.id),
          ),
          loadingBuilder: (_) => const PicnicLoadingIndicator(),
        ),
      );
    } else if (posts.items.isEmpty) {
      content = DarkStatusBar(
        child: RefreshIndicator(
          key: refreshIndicatorKey,
          edgeOffset: refreshIndicatorOffset,
          onRefresh: onRefresh,
          child: ViewInForegroundDetector(
            visibilityFraction: Constants.postVisibilityThreshold,
            viewDidAppear: () => postDidAppear(const Post.empty()),
            child: Center(
              child: NoPostsCard(
                onTapCreatePost: onTapCreatePost,
              ),
            ),
          ),
        ),
      );
    } else {
      content = RefreshIndicator(
        key: refreshIndicatorKey,
        edgeOffset: refreshIndicatorOffset,
        onRefresh: onRefresh,
        child: PostsListVerticalPageView(
          scrollController: scrollController as PageController,
          posts: posts,
          loadMore: loadMore,
          onPostUpdated: onPostUpdated,
          onLongPress: onLongPress,
          postDidAppear: postDidAppear,
          showTimestamps: showTimestamps,
        ),
      );
    }
    return AnimatedSwitcher(
      duration: const LongDuration(),
      switchInCurve: const Interval(
        0.5,
        1,
        curve: Curves.easeOut,
      ),
      child: content,
    );
  }
}
