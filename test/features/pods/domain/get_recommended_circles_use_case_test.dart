import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_input.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_recommended_circles_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetRecommendedCirclesUseCase useCase;

  setUp(() {
    registerFallbackValue(const GetRecommendedCirclesInput.empty());
    useCase = GetRecommendedCirclesUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      when(() => Mocks.podsRepository.getRecommendedCircles(any()))
          .thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

      // WHEN
      final result = await useCase.execute(const GetRecommendedCirclesInput.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetRecommendedCirclesUseCase>();
    expect(useCase, isNotNull);
  });
}
