import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_navigator.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_page.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late DiscoverSearchResultsPage page;
  late DiscoverSearchResultsInitialParams initParams;
  late DiscoverSearchResultsPresentationModel model;
  late DiscoverSearchResultsPresenter presenter;
  late DiscoverSearchResultsNavigator navigator;
  void _initMvp() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    initParams = const DiscoverSearchResultsInitialParams();
    model = DiscoverSearchResultsPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = DiscoverSearchResultsNavigator(
      Mocks.appNavigator,
      Mocks.userStore,
    );
    presenter = DiscoverSearchResultsPresenter(
      model,
      navigator,
      Mocks.searchUsersUseCase,
      Mocks.getCirclesUseCase,
      Mocks.joinCircleUseCase,
      Mocks.followUserUseCase,
      Mocks.debouncer,
    );
    page = DiscoverSearchResultsPage(presenter: presenter);
  }

  await screenshotTest(
    "discover_search_results_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<DiscoverSearchResultsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
