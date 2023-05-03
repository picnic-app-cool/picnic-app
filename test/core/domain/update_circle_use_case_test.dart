import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/domain/use_cases/update_circle_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late UpdateCircleUseCase useCase;

  setUp(() {
    useCase = UpdateCircleUseCase(
      Mocks.circlesRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.circlesRepository.updateCircle(input: const UpdateCircleInput.empty())).thenAnswer(
        (invocation) => successFuture(Stubs.circle),
      );

      // WHEN
      final result = await useCase.execute(
        input: const UpdateCircleInput.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
