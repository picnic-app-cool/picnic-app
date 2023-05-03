import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_circle_role_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late UpdateCircleRoleUseCase useCase;

  setUp(() {
    useCase = UpdateCircleRoleUseCase(
      CirclesMocks.circleModeratorActionsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => CirclesMocks.circleModeratorActionsRepository.updateCircleRole(
          circleCustomRoleUpdateInput: const CircleCustomRoleUpdateInput.empty(),
        ),
      ).thenAnswer((_) => successFuture(const Id.empty()));

      // WHEN
      final result = await useCase.execute(
        circleCustomRoleUpdateInput: const CircleCustomRoleUpdateInput.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case returns failure',
    () async {
      // GIVEN
      when(
        () => CirclesMocks.circleModeratorActionsRepository.updateCircleRole(
          circleCustomRoleUpdateInput: const CircleCustomRoleUpdateInput.empty(),
        ),
      ).thenAnswer((_) => failFuture(const UpdateCircleRoleFailure.unknown()));

      // WHEN
      final result = await useCase.execute(
        circleCustomRoleUpdateInput: const CircleCustomRoleUpdateInput.empty(),
      );

      // THEN
      expect(result.isFailure, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateCircleRoleUseCase>();
    expect(useCase, isNotNull);
  });
}
