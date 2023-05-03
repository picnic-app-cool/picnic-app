import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/cancel_seeds_offer_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late CancelSeedsOfferUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(offerId: Stubs.id, userId: Stubs.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CancelSeedsOfferUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = CancelSeedsOfferUseCase(Mocks.seedsRepository);

    when(() => Mocks.seedsRepository.cancelSeedsOffer(offerId: Stubs.id, userId: Stubs.id))
        .thenAnswer((invocation) => successFuture(unit));
  });
}
