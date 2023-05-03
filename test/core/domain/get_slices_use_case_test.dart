import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_slices_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetSlicesUseCase useCase;

  setUp(() {
    useCase = GetSlicesUseCase(Mocks.slicesRepository);

    when(() => Mocks.slicesRepository.getSlices(nextPageCursor: const Cursor.firstPage(), circleId: Stubs.id))
        .thenAnswer((invocation) => successFuture(const PaginatedList.singlePage()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.firstPage(), circleId: Stubs.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCollectionsUseCase>();
    expect(useCase, isNotNull);
  });
}
