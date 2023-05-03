import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_rules_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late UpdateRulesUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(input: const UpdateCircleInput.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateRulesUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = UpdateRulesUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.updateCircle(input: const UpdateCircleInput.empty()),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.circle),
    );
  });
}
