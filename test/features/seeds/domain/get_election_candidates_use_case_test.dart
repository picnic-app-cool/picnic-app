import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_election_candidates_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late GetElectionCandidatesUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: Stubs.circle.id, nextPageCursor: const Cursor.firstPage());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetElectionCandidatesUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetElectionCandidatesUseCase(Mocks.seedsRepository);

    when(
      () => Mocks.seedsRepository.getElectionCandidates(
        circleId: Stubs.circle.id,
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage(List.filled(2, Stubs.electionCandidate))),
    );

    when(
      () => SeedsMocks.getElectionCandidatesUseCase.execute(
        circleId: Stubs.circle.id,
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((_) {
      return successFuture(PaginatedList.singlePage(List.filled(2, Stubs.electionCandidate)));
    });
  });
}
