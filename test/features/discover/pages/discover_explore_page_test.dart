import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_page.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../../feed/mocks/feed_mock_definitions.dart';
import '../../feed/mocks/feed_mocks.dart';
import '../mocks/discover_mock_definitions.dart';
import '../mocks/discover_mocks.dart';

Future<void> main() async {
  late DiscoverExplorePage page;
  late DiscoverExploreInitialParams initParams;
  late DiscoverExplorePresentationModel model;
  late DiscoverExplorePresenter presenter;
  late DiscoverExploreNavigator navigator;
  late MockDiscoverUseCase useCase;
  late MockGetPopularFeedUseCase popularFeedUseCase;

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => DiscoverMocks.discoverUseCase.execute()).thenAnswer((invocation) {
      return successFuture(<CircleGroup>[]);
    });
    when(() => FeedMocks.getPopularFeedUseCase.execute()).thenAnswer((invocation) {
      return successFuture(Stubs.posts);
    });

    when(
      () => CirclesMocks.getPodsUseCase.execute(
        circleId: any(named: "circleId"),
        cursor: any(named: "cursor"),
      ),
    ).thenAnswer(
      (_) => successFuture(
        const PaginatedList.singlePage(
          [CirclePodApp.empty()],
        ),
      ),
    );
    initParams = const DiscoverExploreInitialParams();
    model = DiscoverExplorePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = DiscoverExploreNavigator(
      Mocks.appNavigator,
      Mocks.userStore,
    );
    useCase = DiscoverMocks.discoverUseCase;
    popularFeedUseCase = FeedMocks.getPopularFeedUseCase;
    presenter = DiscoverExplorePresenter(
      model,
      navigator,
      useCase,
      popularFeedUseCase,
      CirclesMocks.getPodsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = DiscoverExplorePage(presenter: presenter);
  }

  await screenshotTest(
    "discover_explore_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<DiscoverExplorePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
