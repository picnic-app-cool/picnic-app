import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/domain/use_cases/create_circle_role_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CreateCircleRoleUseCase useCase;

  setUp(() {
    useCase = CreateCircleRoleUseCase(CirclesMocks.circleModeratorActionsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => CirclesMocks.circleModeratorActionsRepository.createCircleRole(
          circleCustomRoleInput: const CircleCustomRoleInput.empty(),
        ),
      ).thenAnswer((_) => successFuture(const Id.empty()));

      // WHEN
      final result = await useCase.execute(
        circleCustomRoleInput: const CircleCustomRoleInput.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreateCircleRoleUseCase>();
    expect(useCase, isNotNull);
  });
}
