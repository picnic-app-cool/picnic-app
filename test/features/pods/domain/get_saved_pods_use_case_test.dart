import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_saved_pods_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetSavedPodsUseCase useCase;

  setUp(() {
    useCase = GetSavedPodsUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.podsRepository.getSavedPods(nextPageCursor: any(named: 'nextPageCursor')))
          .thenAnswer((_) => successFuture(const PaginatedList.empty()));

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSavedPodsUseCase>();
    expect(useCase, isNotNull);
  });
}
