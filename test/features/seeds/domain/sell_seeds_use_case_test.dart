import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/model/seeds_offer.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/sell_seeds_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late SellSeedsUseCase useCase;

  setUp(() {
    useCase = SellSeedsUseCase(Mocks.seedsRepository);

    when(
      () => Mocks.seedsRepository.sellSeeds(
        seedsOffer: const SeedsOffer.empty(),
      ),
    ) //
        .thenAnswer((_) => successFuture(unit));

    when(
      () => SeedsMocks.sellSeedsUseCase.execute(seedsOffer: const SeedsOffer.empty()),
    ).thenAnswer((_) => successFuture(unit));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(seedsOffer: const SeedsOffer.empty());
      verify(
        () => Mocks.seedsRepository.sellSeeds(seedsOffer: const SeedsOffer.empty()),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SellSeedsUseCase>();
    expect(useCase, isNotNull);
  });
}
