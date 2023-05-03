import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/un_assign_user_role_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late UnAssignUserRoleUseCase useCase;

  setUp(() {
    useCase = UnAssignUserRoleUseCase(
      CirclesMocks.circleModeratorActionsRepository,
    );

    when(
      () => CirclesMocks.circleModeratorActionsRepository.unAssignRole(
        circleId: any(named: 'circleId'),
        roleId: any(named: 'roleId'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(unit),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.circle.id,
        roleId: Stubs.circleCustomRole.id,
        userId: Stubs.user.id,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UnAssignUserRoleUseCase>();
    expect(useCase, isNotNull);
  });
}
