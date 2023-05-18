import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_page.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late CircleElectionPage page;
  late CircleElectionInitialParams initParams;
  late CircleElectionPresentationModel model;
  late CircleElectionPresenter presenter;
  late CircleElectionNavigator navigator;

  void _initMvp() {
    initParams = CircleElectionInitialParams(circle: Stubs.circle, circleId: Stubs.circle.id);
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 9, 3));
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    model = CircleElectionPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.currentTimeProvider,
    );
    navigator = CircleElectionNavigator(Mocks.appNavigator);
    presenter = CircleElectionPresenter(
      model,
      navigator,
      SeedsMocks.voteDirectorUseCase,
      SeedsMocks.getElectionCandidatesUseCase,
      Mocks.debouncer,
    );
    when(
      () => SeedsMocks.getGovernanceUseCase.execute(circleId: Stubs.circle.id),
    ).thenAnswer(
      (_) => successFuture(
        Stubs.election,
      ),
    );
    when(
      () => SeedsMocks.getElectionCandidatesUseCase.execute(
        circleId: Stubs.circle.id,
        nextPageCursor: any(named: 'nextPageCursor'),
        searchQuery: '',
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          List.filled(
            4,
            Stubs.voteCandidate,
          ),
        ),
      ),
    );
    page = CircleElectionPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_election_page",
    variantName: "graph_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_election_page",
    variantName: "graph_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.enableElectionCircularGraph),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_election_page",
    variantName: "countdown_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_election_page",
    variantName: "countdown_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.enableEectionCountDownWidget),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    _initMvp();
    final page = getIt<CircleElectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
