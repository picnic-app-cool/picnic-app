import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/reject_seeds_offer_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late RejectSeedsOfferUseCase useCase;

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
    final useCase = getIt<RejectSeedsOfferUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = RejectSeedsOfferUseCase(Mocks.seedsRepository);

    when(() => Mocks.seedsRepository.rejectSellSeedsOffer(offerId: Stubs.id, userId: Stubs.id))
        .thenAnswer((invocation) => successFuture(unit));
  });
}
