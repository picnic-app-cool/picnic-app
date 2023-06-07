import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/widgets/main_pages_query.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presenter.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posts_list_page_content.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';

class PostsListPage extends StatefulWidget with HasInitialParams {
  const PostsListPage({
    required this.initialParams,
    Key? key,
  }) : super(key: key);

  @override
  final PostsListInitialParams initialParams;

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage>
    with PresenterStateMixinAuto<PostsListViewModel, PostsListPresenter, PostsListPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();
  late final ScrollController _controller;
  DateTime? _previousReopenedAt;
  bool _pageVisible = false;

  @override
  void initState() {
    super.initState();
    presenter.init();
    _controller = state.gridView ? ScrollController() : PageController();
    _controller.addListener(_controllerListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final selectedTab = MainPagesQuery.maybeOf(context)?.selectedTab;
    final reopenedAt = selectedTab?.reopenTime;
    if (selectedTab?.item == PicnicNavItem.feed &&
        reopenedAt != null &&
        reopenedAt != _previousReopenedAt &&
        _pageVisible) {
      // TODO: we should call presenter here, but due to [RefreshIndicator] limitations it's not possible
      // https://picnic-app.atlassian.net/browse/GS-4165
      _externalRefresh();
      _previousReopenedAt = reopenedAt;
    }
  }

  @override
  void didUpdateWidget(covariant PostsListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    presenter.updateInitialParams(widget.initialParams);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => stateListener(
        listenWhen: (oldState, newState) => oldState.localPost != newState.localPost,
        listener: (context, state) => state.localPost != const Post.empty() ? _jumpToTop() : null,
        child: stateListener(
          listenWhen: (oldState, newState) => oldState.isRefreshing != newState.isRefreshing,
          listener: (context, state) =>
              state.isRefreshing || state.localPost != const Post.empty() ? null : _onRefreshed(),
          child: stateObserver(
            builder: (cxt, state) {
              return ViewInForegroundDetector(
                viewDidAppear: () => _pageVisible = true,
                viewDidDisappear: () => _pageVisible = false,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: PostsListPageContent(
                    isLoading: state.isInitialLoading,
                    isGridView: state.gridView,
                    posts: state.posts,
                    onTapAuthor: presenter.onTapAuthor,
                    onTapCreatePost: presenter.onTapCreatePost,
                    loadMore: presenter.loadMore,
                    onPostUpdated: presenter.onPostUpdated,
                    onLongPress: presenter.onLongPress,
                    postDidAppear: presenter.postDidAppear,
                    onRefresh: presenter.onRefresh,
                    refreshIndicatorKey: _refreshIndicatorKey,
                    scrollController: _controller,
                    showTimestamps: state.showTimestamps,
                  ),
                ),
              );
            },
          ),
        ),
      );

  void _externalRefresh() {
    _refreshIndicatorKey.currentState?.show();
  }

  void _onRefreshed() {
    _jumpToTop();
  }

  void _jumpToTop() {
    if (_controller.positions.isNotEmpty) {
      _controller.jumpTo(0);
    }
  }

  void _controllerListener() {
    FocusScope.of(context).unfocus();
  }
}
