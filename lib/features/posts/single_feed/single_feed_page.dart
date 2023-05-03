import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posts_list_vertical_page_view.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presenter.dart';
import 'package:picnic_app/features/posts/single_feed/widgets/single_feed_app_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_refresh_indicator.dart';

class SingleFeedPage extends StatefulWidget with HasPresenter<SingleFeedPresenter> {
  const SingleFeedPage({
    super.key,
    required this.presenter,
  });

  @override
  final SingleFeedPresenter presenter;

  @override
  State<SingleFeedPage> createState() => _SingleFeedPageState();
}

class _SingleFeedPageState extends State<SingleFeedPage>
    with PresenterStateMixin<SingleFeedViewModel, SingleFeedPresenter, SingleFeedPage> {
  static const _overscrollTriggerOffset = 50;

  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    _controller = PageController(
      initialPage: state.initialIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const refreshIndicatorOffset = 10;

    return stateConsumer(
      listenWhen: (prev, next) => _hasLoadedPostsFromScratch(prev, next),
      listener: (context, state) => _animateToTop(),
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SingleFeedAppBar(
          overlayTheme: state.overlayTheme,
          onTapMoreOptions: presenter.onTapMoreOptions,
          showSortButton: state.showSortButton,
          onTapSort: presenter.onTapSort,
          selectedSortOption: state.selectedSortOption,
        ),
        extendBodyBehindAppBar: true,
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: PicnicRefreshIndicator(
            displacement: MediaQuery.of(context).viewPadding.top + refreshIndicatorOffset,
            isRefreshing: state.isRefreshing,
            onRefresh: presenter.refresh,
            child: PostsListVerticalPageView(
              posts: state.posts,
              onPostUpdated: presenter.onPostUpdated,
              onReport: (_) => presenter.onReport(),
              postDidAppear: presenter.postDidAppear,
              loadMore: presenter.loadMore,
              scrollController: _controller,
              postDetailsMode: PostDetailsMode.details,
            ),
          ),
        ),
      ),
    );
  }

  bool _hasLoadedPostsFromScratch(SingleFeedViewModel prev, SingleFeedViewModel next) =>
      prev.posts.firstOrNull != next.posts.firstOrNull;

  void _animateToTop() {
    _controller.animateToPage(
      0,
      duration: const ShortDuration(),
      curve: Curves.easeOut,
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.pixels - notification.metrics.maxScrollExtent > _overscrollTriggerOffset) {
      presenter.onOverscroll();
    }
    return false;
  }
}
