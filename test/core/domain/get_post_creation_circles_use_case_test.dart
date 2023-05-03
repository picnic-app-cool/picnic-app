import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/get_post_creation_circles_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetPostCreationCirclesUseCase useCase;

  setUp(() {
    useCase = GetPostCreationCirclesUseCase(Mocks.postCreationCirclesRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.postCreationCirclesRepository.getPostCreationCircles(searchQuery: any(named: 'searchQuery')))
          .thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

      // WHEN
      final result = await useCase.execute(searchQuery: '');

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPostCreationCirclesUseCase>();
    expect(useCase, isNotNull);
  });
}
