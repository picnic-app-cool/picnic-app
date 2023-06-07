import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';
import 'package:picnic_app/features/posts/widgets/post_list_item.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_page_view.dart';
import 'package:picnic_app/ui/widgets/picnic_quick_scroll_physics.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PostsListVerticalPageView extends StatefulWidget {
  const PostsListVerticalPageView({
    super.key,
    required this.posts,
    required this.loadMore,
    required this.onPostUpdated,
    required this.onLongPress,
    required this.postDidAppear,
    required this.scrollController,
    this.postDetailsMode = PostDetailsMode.feed,
    this.showTimestamps = true,
  });

  /// determines how many posts before reaching end of list should we start loading next page
  static const loadMorePageOffset = 4.0;
  final Future<void> Function() loadMore;
  final void Function(Post) onLongPress;
  final PaginatedList<Post> posts;
  final void Function(Post) onPostUpdated;
  final void Function(Post) postDidAppear;
  final PageController scrollController;
  final PostDetailsMode postDetailsMode;
  final bool showTimestamps;

  @override
  State<PostsListVerticalPageView> createState() => _PostsListVerticalPageViewState();
}

class _PostsListVerticalPageViewState extends State<PostsListVerticalPageView> implements PostsListInfoListener {
  late PostsListInfoProvider postsListInfoProvider;

  @override
  void initState() {
    super.initState();
    postsListInfoProvider = PostsListInfoProvider(
      postsListProvider: () => widget.posts.items,
      scrollControllerProvider: () => widget.scrollController,
    )..addListener(this);
    postsListInfoProvider.init();
  }

  @override
  void didUpdateWidget(covariant PostsListVerticalPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    postsListInfoProvider.didUpdateWidget();
  }

  @override
  void dispose() {
    super.dispose();
    postsListInfoProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewInForegroundDetector(
      viewDidDisappear: () => _viewDidDisappear(),
      viewDidAppear: () => _viewDidAppear(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return PicnicPagingPageView<Post>(
            controller: widget.scrollController,
            scrollDirection: Axis.vertical,
            loadMoreScrollOffset: constraints.maxHeight * PostsListVerticalPageView.loadMorePageOffset,
            physics: const PicnicQuickScrollPhysics(),

            ///this makes sure we pre-cache some items in advance
            allowImplicitScrolling: true,
            paginatedList: widget.posts,
            loadMore: widget.loadMore,
            itemBuilder: (context, post) {
              return PostListItem(
                onLongPress: widget.onLongPress,
                post: post,
                postsListInfoProvider: postsListInfoProvider,
                onPostUpdated: widget.onPostUpdated,
                postDetailsMode: widget.postDetailsMode,
                showTimestamp: widget.showTimestamps,
              );
            },
            loadingBuilder: (_) => const SizedBox.expand(
              child: Center(
                child: PicnicLoadingIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void postDidAppear(Post post) {
    widget.postDidAppear(post);
  }

  @override
  void listDidDisappear() {
    doNothing();
  }

  void _viewDidDisappear() {
    postsListInfoProvider.onListDisappeared();
  }

  void _viewDidAppear() {
    postsListInfoProvider.onListAppeared();
  }
}
