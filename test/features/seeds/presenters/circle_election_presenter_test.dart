import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/seeds_mock_definitions.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late CircleElectionPresentationModel model;
  late CircleElectionPresenter presenter;
  late MockCircleElectionNavigator navigator;
  void _initMvp({CircleElectionInitialParams? initParams}) {
    model = CircleElectionPresentationModel.initial(
      initParams ?? CircleElectionInitialParams(circle: Stubs.circle),
      Mocks.featureFlagsStore,
      Mocks.currentTimeProvider,
    );
    navigator = MockCircleElectionNavigator();
    presenter = CircleElectionPresenter(
      model,
      navigator,
      SeedsMocks.voteDirectorUseCase,
      SeedsMocks.getElectionCandidatesUseCase,
      SeedsMocks.getElectionUseCase,
      CirclesMocks.getCircleDetailsUseCase,
    );
  }

  test(
    'should load circle details and then election details if no circle is passed',
    () async {
      // GIVEN
      _initMvp(initParams: CircleElectionInitialParams.byId(circleId: Stubs.circle.id));

      // WHEN
      await presenter.onInit();

      // THEN
      verifyInOrder([
        () => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.circle.id),
        () => SeedsMocks.getElectionUseCase.execute(circleId: Stubs.circle.id),
      ]);
    },
  );

  setUp(() {
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8, 16));
    when(
      () => SeedsMocks.getElectionUseCase.execute(circleId: Stubs.circle.id),
    ).thenAnswer((_) => successFuture(Stubs.election));

    when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.circle.id))
        .thenSuccess((_) => Stubs.circle);

    when(
      () => SeedsMocks.getElectionCandidatesUseCase
          .execute(circleId: Stubs.circle.id, nextPageCursor: any(named: 'nextPageCursor')),
    ).thenAnswer((_) => successFuture(PaginatedList.singlePage(List.filled(3, Stubs.electionCandidate))));
  });
}
