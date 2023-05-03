import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/model/get_user_seeds_total_failure.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_user_seeds_total_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetUserSeedsTotalUseCase useCase;

  setUp(() {
    useCase = GetUserSeedsTotalUseCase(Mocks.seedsRepository);
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserSeedsTotalUseCase>();
    expect(useCase, isNotNull);
  });

  test('should successfully return from repository when get total seeds', () async {
    // GIVEN
    when(
      () => Mocks.seedsRepository.getUserSeedsTotal(),
    ).thenAnswer((_) => successFuture(0));

    // WHEN
    final result = await useCase.execute();

    // THEN
    expect(result.isSuccess, true);
    verify(
      () => Mocks.seedsRepository.getUserSeedsTotal(),
    ).called(1);
  });

  test('should fail from repository when get total seeds', () async {
    // GIVEN
    when(
      () => Mocks.seedsRepository.getUserSeedsTotal(),
    ).thenAnswer((_) => failFuture(const GetUserSeedsTotalFailure.unknown()));

    // WHEN
    final result = await useCase.execute();

    // THEN
    expect(result.isFailure, true);
    verify(
      () => Mocks.seedsRepository.getUserSeedsTotal(),
    ).called(1);
  });
}
