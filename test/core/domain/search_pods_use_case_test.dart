import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/use_cases/search_pods_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SearchPodsUseCase useCase;

  setUp(() {
    useCase = SearchPodsUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.podsRepository.searchPods(input: any(named: "input")))
          .thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

      // WHEN
      final result = await useCase.execute(input: const SearchPodInput.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SearchPodsUseCase>();
    expect(useCase, isNotNull);
  });
}
