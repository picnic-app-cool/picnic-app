import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  setUp(() {
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8, 16));
    when(
      () => SeedsMocks.getGovernanceUseCase.execute(circleId: Stubs.circle.id),
    ).thenAnswer((_) => successFuture(Stubs.election));

    when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.circle.id))
        .thenSuccess((_) => Stubs.circle);

    when(
      () => SeedsMocks.getElectionCandidatesUseCase.execute(
        circleId: Stubs.circle.id,
        nextPageCursor: any(named: 'nextPageCursor'),
        searchQuery: '',
      ),
    ).thenAnswer((_) => successFuture(PaginatedList.singlePage(List.filled(3, Stubs.voteCandidate))));
  });
}
