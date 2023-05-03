import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_page.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';

class FeedsPageView extends StatefulWidget {
  const FeedsPageView({
    Key? key,
    required this.onFeedChangedByIndex,
    required this.selectedFeedIndex,
    required this.onPostChanged,
    required this.feedsList,
    required this.localPostFeedIndex,
    this.localPost = const Post.empty(),
  }) : super(key: key);

  final ValueChanged<int> onFeedChangedByIndex;
  final int selectedFeedIndex;
  final OnDisplayedPostChangedCallback onPostChanged;
  final List<Feed> feedsList;

  final int localPostFeedIndex;
  final Post localPost;

  @override
  State<FeedsPageView> createState() => _FeedsPageViewState();
}

class _FeedsPageViewState extends State<FeedsPageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.selectedFeedIndex,
    )..addListener(_onPageControllerUpdate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FeedsPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedFeedIndex != _pageController.page?.round()) {
      _animateToPage();
    }
    if (widget.localPost != oldWidget.localPost && widget.localPost != const Post.empty()) {
      _jumpToLocalPostFeed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      //we want the bounce effect to be disabled on feed horizontal navigation
      physics: const ClampingScrollPhysics(),
      controller: _pageController,
      itemBuilder: (context, index) => maybeGetIt<PostsListPage>(
        orElse: () => PostsListPage(
          initialParams: PostsListInitialParams(
            onPostChanged: widget.onPostChanged,
            feed: widget.feedsList[index],
            localPost: index == widget.localPostFeedIndex ? widget.localPost : const Post.empty(),
          ),
        ),
      ),
      allowImplicitScrolling: true,
      itemCount: widget.feedsList.length,
    );
  }

  void _onPageControllerUpdate() {
    FocusScope.of(context).unfocus();
    final index = _pageController.page?.round() ?? 0;
    if (index != widget.selectedFeedIndex) {
      widget.onFeedChangedByIndex(index);
    }
  }

  Future<void> _animateToPage() async {
    _pageController.removeListener(_onPageControllerUpdate);
    await _pageController.animateToPage(
      widget.selectedFeedIndex,
      duration: const ShortDuration(),
      curve: Curves.easeOutQuad,
    );
    _pageController.addListener(_onPageControllerUpdate);
  }

  void _jumpToLocalPostFeed() {
    if (_pageController.positions.isNotEmpty) {
      _pageController.jumpToPage(widget.localPostFeedIndex);
    }
  }
}
