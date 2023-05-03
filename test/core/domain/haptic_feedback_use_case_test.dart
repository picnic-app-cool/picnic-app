import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late HapticFeedbackUseCase useCase;

  setUp(() {
    useCase = HapticFeedbackUseCase(Mocks.hapticRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.hapticRepository.lightImpact(),
      ).thenAnswer(
        (invocation) => successFuture(unit),
      );

      // WHEN
      await useCase.execute();

      // THEN
      verify(() => Mocks.hapticRepository.lightImpact());
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<HapticFeedbackUseCase>();
    expect(useCase, isNotNull);
  });
}
