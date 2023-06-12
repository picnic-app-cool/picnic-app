import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_last_used_circles_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetLastUsedCirclesUseCase useCase;

  setUp(() {
    useCase = GetLastUsedCirclesUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.getLastUsedCircles(
        nextPageCursor: const Cursor.empty(),
      ),
    ).thenAnswer(
      (invocation) => successFuture(const PaginatedList.singlePage()),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        cursor: const Cursor.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetLastUsedCirclesUseCase>();
    expect(useCase, isNotNull);
  });
}
