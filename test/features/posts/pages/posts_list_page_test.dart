import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_pinned_comments_use_case.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_navigator.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_page.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presenter.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posts_list_vertical_page_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../feed_tests_utils.dart';
import '../mocks/posts_mocks.dart';

final getPostsUseCaseStub = PostsMocks.getPostsListUseCase.execute(
  feed: any(named: 'feed'),
  searchQuery: any(named: 'searchQuery'),
  cursor: any(named: 'cursor'),
  cachePolicy: any(named: 'cachePolicy'),
);

Future<void> main() async {
  setUpAll(() {
    getIt.registerFactory<GetCommentsUseCase>(() => PostsMocks.getCommentsUseCase);
    getIt.registerFactory<GetPinnedCommentsUseCase>(() => PostsMocks.getPinnedCommentsUseCase);
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2023, 3, 26));
    when(() => PostsMocks.getCommentsUseCase.execute(post: any(named: "post")))
        .thenAnswer((_) => successFuture(Stubs.comments));
    when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: any(named: "post")))
        .thenAnswer((_) => successFuture([]));
  });

  late PostsListPage page;
  late PostsListInitialParams initialParams;
  late PostsListPresentationModel model;
  late PostsListPresenter presenter;
  late PostsListNavigator navigator;

  Future<void> _initMvp({bool gridView = false}) async {
    reRegister<FeatureFlagsStore>(Mocks.featureFlagsStore);
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    mockCommentsPreview();
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initialParams = PostsListInitialParams(
      gridView: gridView,
      feed: const Feed.empty(),
      onPostChanged: (Post post) {},
    );
    model = PostsListPresentationModel.initial(
      initialParams,
      Mocks.userStore,
    );
    navigator = PostsListNavigator(
      Mocks.appNavigator,
      Mocks.userStore,
    );
    presenter = PostsListPresenter(
      model,
      navigator,
      PostsMocks.getPostsListUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      CirclesMocks.getCircleDetailsUseCase,
    );
    getIt.registerFactoryParam<PostsListPresenter, PostsListInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = PostsListPage(
      initialParams: initialParams,
    );
  }

  await screenshotTest(
    "posts_list_page",
    variantName: 'list',
    setUp: () async {
      await _initMvp();
      when(() => getPostsUseCaseStub).thenAnswer((_) => successCacheableResult(Stubs.posts));
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "posts_list_page",
    variantName: 'grid',
    setUp: () async {
      await _initMvp(gridView: true);
      when(
        () => PostsMocks.getPostsListUseCase.execute(
          feed: Stubs.feed,
          searchQuery: '',
          cursor: const Cursor.empty(),
          cachePolicy: any(named: "cachePolicy"),
        ),
      ).thenAnswer(
        (_) => successCacheableResult(
          Stubs.posts.copyWith(
            pageInfo: const PageInfo.singlePage().copyWith(
              nextPageId: Id(
                Random().nextDouble().toString(),
              ),
            ),
          ),
        ),
      );
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "posts_list_page",
    variantName: 'empty',
    setUp: () async {
      await _initMvp();
      when(
        () => getPostsUseCaseStub,
      ).thenAnswer((_) => Stream.value(CacheableResult(result: success(const PaginatedList.empty()))));
    },
    pageBuilder: () => page,
  );

  testWidgets(
    'preloading feeds works',
    (tester) async {
      //GIVEN
      Future<void> _switchToNextPage() async {
        await tester.fling(
          find.byType(PostsListVerticalPageView),
          const Offset(0, -200),
          800,
        );
        await tester.pumpAndSettle();
      }

      when(
        () => getPostsUseCaseStub,
      ).thenAnswer(
        (_) => successCacheableResult(
          PaginatedList(
            items: List.generate(10, (index) => Stubs.textPost),
            pageInfo: const PageInfo.firstPage().copyWith(
              nextPageId: const Id('next-page'),
            ),
          ),
        ),
      );
      await _initMvp();
      await tester.pumpWidget(
        PicnicTheme(
          child: MaterialApp(
            home: page,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(presenter.state.posts.items.length, 10);
      verify(() => getPostsUseCaseStub);

      //WHEN

      // scroll trough 6 posts initially
      for (var i = 0; i < 5; i++) {
        await _switchToNextPage();
      }
      verifyNever(() => getPostsUseCaseStub);
      await _switchToNextPage();
      //THEN
      verify(() => getPostsUseCaseStub);
      expect(presenter.state.posts.items.length, 20);
    },
  );

  tearDown(() {
    return VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });
}
