import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_user_roles_in_circle_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetUserRolesInCircleUseCase useCase;

  setUp(() {
    useCase = GetUserRolesInCircleUseCase(
      Mocks.circlesRepository,
    );

    when(
      () => Mocks.circlesRepository.getUserRolesInCircle(
        circleId: any(named: 'circleId'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(const CircleMemberCustomRoles.empty()),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.circle.id,
        userId: Stubs.publicProfile.id,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserRolesInCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
