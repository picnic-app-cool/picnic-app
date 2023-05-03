import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/use_cases/get_circles_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetCirclesUseCase useCase;
  late CirclesRepository circlesRepository;

  setUp(() {
    circlesRepository = Mocks.circlesRepository;
    useCase = GetCirclesUseCase(circlesRepository);

    when(() => Mocks.circlesRepository.getCircles())
        .thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCirclesUseCase>();
    expect(useCase, isNotNull);
  });
}
