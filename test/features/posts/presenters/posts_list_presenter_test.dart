import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cache_policy.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';
import 'package:picnic_app/features/posts/domain/model/get_feed_posts_list_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late PostsListPresentationModel model;
  late PostsListPresenter presenter;
  late MockPostsListNavigator navigator;

  void _configurePresenter({
    Post localPost = const Post.empty(),
    Feed feed = const Feed.empty(),
  }) {
    model = PostsListPresentationModel.initial(
      PostsListInitialParams(
        feed: feed,
        localPost: localPost,
        onPostChanged: (Post post) {},
      ),
      Mocks.userStore,
    );
    navigator = MockPostsListNavigator();
    presenter = PostsListPresenter(
      model,
      navigator,
      PostsMocks.getPostsListUseCase,
      CirclesMocks.getCircleDetailsUseCase,
    );
  }

  test(
    'should load first page on start',
    () async {
      await presenter.init();
      expect(presenter.state.posts.items.isNotEmpty, true);
      verify(() => _postsListUseCaseExecuteMatch());
    },
  );

  test(
    'should load from cache first then immediately from network',
    () async {
      when(() => _postsListUseCaseExecuteMatch()).thenAnswer(
        (invocation) => Stream.fromIterable([
          CacheableResult(result: success(PaginatedList.singlePage([Stubs.linkPost])), source: CacheableSource.cache),
          CacheableResult(result: success(Stubs.posts), source: CacheableSource.network),
        ]),
      );
      _configurePresenter();
      await presenter.init();
      // checks that list in state replaces the cached one with network results
      expect(presenter.state.posts, Stubs.posts);
      verify(() => _postsListUseCaseExecuteMatch(cachePolicy: CachePolicy.cacheOnly));
      verify(() => _postsListUseCaseExecuteMatch());
    },
  );

  test(
    "should load first page on start when local post provided",
    () async {
      _configurePresenter(
        localPost: Stubs.textPost.copyWith(
          id: const Id('unique-id'),
        ),
      );
      expect(presenter.state.posts.items.length, 1);
      await presenter.init();
      verify(() => _postsListUseCaseExecuteMatch());
      expect(presenter.state.posts.items.length, Stubs.posts.items.length + 1);
    },
  );

  test(
    'should report isInitialLoading as true when loading first page',
    () async {
      final completer = Completer<Either<GetFeedPostsListFailure, PaginatedList<Post>>>();
      when(() => _postsListUseCaseExecuteMatch())
          .thenAnswer((invocation) => completer.future.then((value) => CacheableResult(result: value)).asStream());
      unawaited(presenter.init());
      expect(presenter.state.isInitialLoading, isTrue);
      completer.complete(success(Stubs.posts));
      await completer.future;
      expect(presenter.state.isInitialLoading, isFalse);
    },
  );

  test(
    'should report isInitialLoading as true when loading first page and local post provided',
    () async {
      _configurePresenter(
        localPost: Stubs.textPost.copyWith(
          id: const Id('unique-id'),
        ),
      );
      final completer = Completer<Either<GetFeedPostsListFailure, PaginatedList<Post>>>();
      when(() => _postsListUseCaseExecuteMatch())
          .thenAnswer((invocation) => completer.future.then((value) => CacheableResult(result: value)).asStream());
      unawaited(presenter.init());
      expect(presenter.state.isInitialLoading, isTrue);
      completer.complete(success(Stubs.posts));
      await completer.future;
      expect(presenter.state.isInitialLoading, isFalse);
    },
  );

  test(
    '"for you" feed should hide timestamps',
    () async {
      _configurePresenter(
        feed: const Feed.empty().copyWith(feedType: FeedType.user, name: "for you"),
        localPost: Stubs.textPost.copyWith(
          id: const Id('unique-id'),
        ),
      );
      expect(presenter.state.showTimestamps, isFalse);
    },
  );

  test(
    'circle feeds should show timestamps',
    () async {
      _configurePresenter(
        feed: Stubs.feed.copyWith(feedType: FeedType.circle),
        localPost: Stubs.textPost.copyWith(
          id: const Id('unique-id'),
        ),
      );
      expect(presenter.state.showTimestamps, isTrue);
    },
  );

  setUp(() {
    when(
      () => _postsListUseCaseExecuteMatch(),
    ).thenAnswer((_) => successCacheableResult(Stubs.posts));
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    _configurePresenter();
  });
}

Stream<CacheableResult<GetFeedPostsListFailure, PaginatedList<Post>>> _postsListUseCaseExecuteMatch({
  CachePolicy? cachePolicy,
}) {
  return PostsMocks.getPostsListUseCase.execute(
    feed: any(named: 'feed'),
    searchQuery: any(named: 'searchQuery'),
    cursor: any(named: 'cursor'),
    cachePolicy: cachePolicy ?? any(named: 'cachePolicy'),
  );
}
