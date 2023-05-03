import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/domain/use_cases/create_circle_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/create_circle_mocks.dart';

void main() {
  late CreateCircleUseCase useCase;

  setUp(() {
    useCase = CreateCircleUseCase(
      CreateCircleMocks.circleCreationRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => CreateCircleMocks.circleCreationRepository.createCircle(input: any(named: 'input')))
          .thenAnswer((_) => successFuture(Stubs.circle));

      // WHEN
      final result = await useCase.execute(input: const CircleInput.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreateCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
