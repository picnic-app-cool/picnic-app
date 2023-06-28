import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_circles_for_interests_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCirclesForInterestsUseCase useCase;

  setUp(() {
    useCase = GetCirclesForInterestsUseCase(
      Mocks.circlesRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.circlesRepository.getCirclesForInterests([
          const Id('1'),
          const Id('2'),
        ]),
      ).thenAnswer((_) => successFuture([const Id('circleId1'), const Id('circleId2'), const Id('circleId3')]));

      // WHEN
      final result = await useCase.execute([
        const Id('1'),
        const Id('2'),
      ]);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCirclesForInterestsUseCase>();
    expect(useCase, isNotNull);
  });
}
