import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_election_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late GetElectionUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: Stubs.circle.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetElectionUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetElectionUseCase(Mocks.seedsRepository);

    when(
      () => Mocks.seedsRepository.getElection(circleId: Stubs.circle.id),
    ).thenAnswer((_) => successFuture(Stubs.election));

    when(
      () => SeedsMocks.getElectionUseCase.execute(circleId: Stubs.circle.id),
    ).thenAnswer((_) {
      return successFuture(Stubs.election);
    });
  });
}
