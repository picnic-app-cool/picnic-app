import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_default_circle_config_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late GetDefaultCircleConfigUseCase useCase;

  setUp(() {
    useCase = GetDefaultCircleConfigUseCase(CirclesMocks.circleModeratorActionsRepository);
    when(
      () => CirclesMocks.circleModeratorActionsRepository.getDefaultCircleConfig(),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.circleConfig),
    );
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
    final useCase = getIt<GetDefaultCircleConfigUseCase>();
    expect(useCase, isNotNull);
  });
}
