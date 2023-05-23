import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_initial_params.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_navigator.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_page.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presenter.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_page.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presenter.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../posts/mocks/posts_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/feed_mocks.dart';

Future<void> main() async {
  late FeedHomePage page;
  late FeedHomeInitialParams initParams;
  late FeedHomePresentationModel model;
  late FeedHomePresenter presenter;
  late FeedHomeNavigator navigator;

  void _initPostUploadingProgressMvp() {
    when(() => Mocks.backgroundApiRepository.getProgressStream<Post, CreatePostFailure, Post>())
        .thenAnswer((_) => const Stream.empty());
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    final postUploadingProgressInitParams = PostUploadingProgressInitialParams(onPostToBeShown: (_) {});
    final postUploadingProgressModel = PostUploadingProgressPresentationModel.initial(
      postUploadingProgressInitParams,
      Mocks.currentTimeProvider,
    );
    final postUploadingProgressPresenter = PostUploadingProgressPresenter(
      postUploadingProgressModel,
      PostsMocks.postUploadingProgressNavigator,
      Mocks.backgroundApiRepository,
      avoidTimers: true,
    );
    getIt.registerFactoryParam<PostUploadingProgressPresenter, PostUploadingProgressInitialParams, dynamic>(
      (initialParams, _) => postUploadingProgressPresenter,
    );
  }

  void _initMvp({Post? post}) {
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    when(() => Mocks.userCirclesStore.userCircles).thenReturn(const PaginatedList.singlePage([]));
    when(() => FeedMocks.localFeedsStore.feeds).thenReturn(Stubs.unmodifiableFeedList);
    when(() => FeedMocks.localFeedsStore.stream).thenAnswer((_) => Stubs.feedStream);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initParams = FeedHomeInitialParams(
      onPostChanged: (Post? post) {},
      onCirclesSideMenuToggled: () {},
    );
    model = FeedHomePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userCirclesStore,
      Mocks.userStore,
    ).copyWith(
      currentPost: post,
    );
    navigator = FeedHomeNavigator(Mocks.appNavigator);

    when(() => ProfileMocks.getUnreadNotificationsCountUseCase.execute()).thenAnswer(
      (invocation) => successFuture(const UnreadNotificationsCount(count: 7)),
    );

    when(() => Mocks.updateAppBadgeCountUseCase.execute(any())).thenAnswer((_) => Future.value());

    presenter = FeedHomePresenter(
      model,
      navigator,
      FeedMocks.getFeedsListUseCase,
      FeedMocks.getViewPostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      FeedMocks.localFeedsStore,
      ProfileMocks.getUnreadNotificationsCountUseCase,
      Mocks.updateAppBadgeCountUseCase,
      Mocks.userCirclesStore,
    );
    page = FeedHomePage(presenter: presenter);
  }

  await screenshotTest(
    "feed_home_page",
    setUp: () async {
      _initMvp(post: Stubs.videoPost);
      // just to be sure we don't accidentally use real pages and real backend calls inside the test
      await getIt.reset();
      _initPostUploadingProgressMvp();
      getIt.registerFactory<PostsListPage>(() => const _TestPostsListPage());
      getIt.registerFactory<PostsListPresenter>(() => PostsMocks.postsListPresenter);
      when(() => FeedMocks.getFeedsListUseCase.execute(nextPageCursor: any(named: 'nextPageCursor')))
          .thenAnswer((_) => successCacheableResult(PaginatedList.singlePage([Stubs.feed])));
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "feed_home_page_empty_view",
    setUp: () async {
      _initMvp();
      // just to be sure we don't accidentally use real pages and real backend calls inside the test
      await getIt.reset();
      when(() => FeedMocks.getFeedsListUseCase.execute(nextPageCursor: any(named: 'nextPageCursor')))
          .thenAnswer((_) => successCacheableResult(const PaginatedList.singlePage([])));
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await configureDependenciesForTests();
    _initMvp();
    final page = getIt<FeedHomePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

//ignore: avoid_implementing_value_types
class _TestPostsListPage extends StatefulWidget implements PostsListPage {
  const _TestPostsListPage({Key? key}) : super(key: key);

  @override
  State<_TestPostsListPage> createState() => _TestPostsListPageState();

  @override
  PostsListInitialParams get initialParams => throw UnimplementedError();
}

class _TestPostsListPageState extends State<_TestPostsListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "TEST POSTS LIST PAGE",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
