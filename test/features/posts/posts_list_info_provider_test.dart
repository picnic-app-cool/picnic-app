import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';

import '../../mocks/stubs.dart';

void main() {
  late PostsListInfoProvider provider;
  late PageController scrollController;
  late List<Post> posts;

  test("provider should assume list is invisible by default", () {
    // its because some lists are initialized as part of off-screen pages in view pager and those
    // do not receive `onDidDisappear` event from ViewInForegroundDetector by default
    expect(provider.isListVisible, false);
  });

  test("by default provider should return empty post as currently visible", () {
    expect(provider.currentPost, const Post.empty());
    expect(provider.currentIndex, -1);
  });

  test("disposing provider should inform its listeners about list disappearance", () {
    // GIVEN
    final listener = MockPostsListInfoListener();
    provider.init();
    provider.addListener(listener);
    provider.dispose();
    verify(() => listener.listDidDisappear());
  });

  test("calling onListAppeared should notify listeners about current state", () {
    // GIVEN
    final listener = MockPostsListInfoListener();
    when(() => scrollController.positions).thenReturn([MockScrollPosition()]);
    when(() => scrollController.page).thenReturn(0.0);
    posts = [Stubs.textPost];

    //WHEN
    provider.init();
    provider.addListener(listener);
    provider.onListAppeared();

    //THEN
    verify(() => listener.postDidAppear(Stubs.textPost));
  });

  setUp(() {
    posts = [];
    scrollController = MockPageController();
    provider = PostsListInfoProvider(
      scrollControllerProvider: () => scrollController,
      postsListProvider: () => posts,
    );
  });
}

class MockPostsListInfoListener extends Mock implements PostsListInfoListener {}

class MockPageController extends Mock implements PageController {}

class MockScrollPosition extends Mock implements ScrollPosition {}
