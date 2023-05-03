import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seeds_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late GetSeedsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.firstPage());
      verify(() => Mocks.seedsRepository.getSeeds(nextPageCursor: any(named: "nextPageCursor"), searchQuery: ''));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSeedsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    final seeds = PaginatedList(items: [Stubs.seed], pageInfo: const PageInfo.empty());

    useCase = GetSeedsUseCase(Mocks.seedsRepository);

    when(() => Mocks.seedsRepository.getSeeds(nextPageCursor: any(named: "nextPageCursor"), searchQuery: ''))
        .thenAnswer((_) => successFuture(PaginatedList(items: [Stubs.seed], pageInfo: const PageInfo.empty())));

    when(() => SeedsMocks.getSeedsUseCase.execute(nextPageCursor: any(named: "nextPageCursor"))).thenAnswer((_) {
      return successFuture(seeds);
    });
  });
}
