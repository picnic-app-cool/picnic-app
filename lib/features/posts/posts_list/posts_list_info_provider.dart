import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

/// Provides info about current state of the posts list to its child widgets, useful for determining
/// if current post is visible to either start or stop the playback of the video
class PostsListInfoProvider {
  PostsListInfoProvider({
    required PageController Function() scrollControllerProvider,
    required List<Post> Function() postsListProvider,
  })  : _scrollController = scrollControllerProvider(),
        _scrollControllerProvider = scrollControllerProvider,
        _postsListProvider = postsListProvider;

  // by default we assume list is not visible until we receive explicit call to `onListAppeared` callback
  @visibleForTesting
  bool isListVisible = false;

  final PageController Function() _scrollControllerProvider;
  final List<Post> Function() _postsListProvider;
  late PageController _scrollController;
  final List<PostsListInfoListener> _listeners = [];

  late VoidCallback _scrollListener;
  late int _previousIndex;

  Post get currentPost {
    final posts = _postsListProvider();
    return isListVisible && posts.isNotEmpty && currentIndex < posts.length ? posts[currentIndex] : const Post.empty();
  }

  int get currentIndex {
    if (isListVisible && _scrollControllerProvider().positions.isNotEmpty) {
      return _scrollControllerProvider().page?.round() ?? 0;
    }
    return -1;
  }

  void init() {
    _previousIndex = currentIndex;
    _scrollListener = () {
      if (currentIndex != _previousIndex) {
        _previousIndex = currentIndex;
        _notifyListeners();
      }
    };
    _scrollControllerProvider().addListener(_scrollListener);
  }

  void addListener(PostsListInfoListener listener) {
    _listeners.add(listener);
  }

  void removeListener(PostsListInfoListener listener) {
    _listeners.remove(listener);
  }

  void dispose() {
    onListDisappeared();
    _listeners.clear();
    _scrollController.removeListener(_scrollListener);
  }

  void onListDisappeared() {
    isListVisible = false;
    _notifyListeners();
  }

  void onListAppeared() {
    isListVisible = true;
    _notifyListeners();
  }

  void didUpdateWidget() {
    _updateScrollController();

    //just to make sure, lets notify listeners of the current post being displayed
    _notifyListeners();
  }

  void _updateScrollController() {
    final newController = _scrollControllerProvider();
    if (newController != _scrollController) {
      _scrollController.removeListener(_scrollListener);
      newController.addListener(_scrollListener);
      _scrollController = newController;
    }
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      if (isListVisible) {
        listener.postDidAppear(currentPost);
      } else {
        listener.listDidDisappear();
      }
    }
  }
}

abstract class PostsListInfoListener {
  void postDidAppear(Post post);

  void listDidDisappear();
}
