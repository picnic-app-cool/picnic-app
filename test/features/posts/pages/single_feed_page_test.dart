import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_preview_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_pinned_comments_use_case.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_page.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presenter.dart';
import 'package:picnic_app/features/posts/single_feed/sorting_handler.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late SingleFeedPage page;
  late SingleFeedInitialParams initParams;
  late SingleFeedPresentationModel model;
  late SingleFeedPresenter presenter;
  late SingleFeedNavigator navigator;

  setUpAll(() {
    getIt.registerFactory<GetCommentsPreviewUseCase>(() => PostsMocks.getCommentsPreviewUseCase);
    getIt.registerFactory<GetCommentsUseCase>(() => PostsMocks.getCommentsUseCase);
    getIt.registerFactory<GetPinnedCommentsUseCase>(() => PostsMocks.getPinnedCommentsUseCase);
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2023, 3, 26));
    when(() => PostsMocks.getCommentsUseCase.execute(post: any(named: "post")))
        .thenAnswer((_) => successFuture(Stubs.comments));
    when(
      () => PostsMocks.getCommentsPreviewUseCase.execute(
        postId: any(named: 'postId'),
        count: any(named: 'count'),
      ),
    ).thenAnswer((_) => successFuture(Stubs.commentsPreview));
    when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: any(named: "post")))
        .thenAnswer((_) => successFuture([]));
  });

  void initMvp({SortingHandler? sortingHandler, PaginatedList<Post>? posts}) {
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.viewPostUseCase.execute(postId: any(named: 'postId'))).thenAnswer((_) => successFuture(unit));

    initParams = SingleFeedInitialParams(
      initialIndex: 0,
      loadMore: () => successFuture(posts ?? Stubs.posts),
      refresh: () => successFuture(posts ?? Stubs.posts),
      onPostsListUpdated: (_) {},
      preloadedPosts: posts ?? Stubs.posts,
      sortingHandler: sortingHandler,
    );

    model = SingleFeedPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );

    navigator = SingleFeedNavigator(Mocks.appNavigator);
    presenter = SingleFeedPresenter(
      model,
      navigator,
      Mocks.deletePostsUseCase,
      Mocks.viewPostUseCase,
      Mocks.throttler,
    );

    page = SingleFeedPage(presenter: presenter);
  }

  await screenshotTest(
    "single_feed_page",
    timeout: const Duration(seconds: 10),
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "single_feed_page",
    variantName: "sorting_light",
    setUp: () async {
      initMvp(
        posts: Stubs.posts.copyWith(items: [Stubs.textPost]),
        sortingHandler: SortingHandler(
          selectedSortOption: () => PostsSortingType.popularAllTime,
          onTapSort: () async => doNothing(),
        ),
      );
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "single_feed_page",
    variantName: "sorting_dark",
    setUp: () async {
      initMvp(
        posts: Stubs.posts.copyWith(items: [Stubs.videoPost]),
        sortingHandler: SortingHandler(
          selectedSortOption: () => PostsSortingType.popularAllTime,
          onTapSort: () async => doNothing(),
        ),
      );
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<SingleFeedPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
