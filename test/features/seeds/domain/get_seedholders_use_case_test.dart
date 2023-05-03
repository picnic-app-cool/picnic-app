import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seed_holders_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late GetSeedHoldersUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: Stubs.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSeedHoldersUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetSeedHoldersUseCase(Mocks.seedsRepository);

    when(() => Mocks.seedsRepository.getSeedHolders(circleId: Stubs.id)).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage(List.filled(5, const SeedHolder.empty()))),
    );

    when(() => SeedsMocks.getSeedholdersUseCase.execute(circleId: Stubs.id)).thenAnswer((_) {
      return successFuture(PaginatedList.singlePage(List.filled(5, const SeedHolder.empty())));
    });
  });
}
