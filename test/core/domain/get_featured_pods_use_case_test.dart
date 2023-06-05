import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/get_featured_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_pods_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetFeaturedPodsUseCase useCase;

  setUp(() {
    useCase = GetFeaturedPodsUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.podsRepository.getFeaturedPods(nextPageCursor: any(named: "nextPageCursor")))
          .thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SearchPodsUseCase>();
    expect(useCase, isNotNull);
  });
}
