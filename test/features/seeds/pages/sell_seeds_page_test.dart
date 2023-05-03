import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/analytics_observer.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presenter.dart';
import 'package:picnic_app/navigation/utils/root_navigator_observer.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late SellSeedsPage page;
  late SellSeedsInitialParams initParams;
  late SellSeedsPresentationModel model;
  late SellSeedsPresenter presenter;
  late SellSeedsNavigator navigator;

  void _initMvp() {
    final key = SellSeedsNavigatorKey();
    initParams = SellSeedsInitialParams(onTransferSeedsCallback: () {});
    model = SellSeedsPresentationModel.initial(
      initParams,
    );
    navigator = SellSeedsNavigator(
      Mocks.appNavigator,
      key,
    );
    presenter = SellSeedsPresenter(
      model,
      navigator,
    );
    page = SellSeedsPage(
      presenter: presenter,
      navigatorKey: key,
    );
  }

  SellSeedsFirstStepPage _getFirstStepPage() {
    final key = SellSeedsNavigatorKey();
    final initParams = SellSeedsFirstStepInitialParams(
      onChooseCircle: (
        Seed seed,
      ) {},
    );
    final model = SellSeedsFirstStepPresentationModel.initial(
      initParams,
    );
    final sellSeedsNavigator = SellSeedsNavigator(Mocks.appNavigator, key);

    when(
      () => SeedsMocks.getSeedsUseCase.execute(
        nextPageCursor: any(named: "nextPageCursor"),
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList(items: List.filled(10, Stubs.seed), pageInfo: const PageInfo.empty())),
    );

    final presenter = SellSeedsFirstStepPresenter(
      model,
      sellSeedsNavigator,
      SeedsMocks.getSeedsUseCase,
      Mocks.debouncer,
    );
    return SellSeedsFirstStepPage(presenter: presenter);
  }

  await screenshotTest(
    "sell_seeds_page",
    devices: [testDevices.last],
    setUp: () async {
      when(
        () => Mocks.appNavigator.pushReplacement<void>(
          any(),
          context: any(named: "context"),
          useRoot: any(named: "useRoot"),
        ),
      ) //
          .thenAnswer((invocation) => Future.value());
      _initMvp();
      await getIt.reset();
      getIt.registerFactory<RootNavigatorObserver>(() => RootNavigatorObserver());
      getIt.registerFactory<AnalyticsObserver>(() => MockAnalyticsObserver());
      getIt.registerFactory<SellSeedsFirstStepPage>(() => _getFirstStepPage());
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await configureDependenciesForTests();
    _initMvp();
    final page = getIt<SellSeedsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
