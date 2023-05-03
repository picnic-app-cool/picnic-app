import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/domain/use_cases/invite_user_to_circle_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late InviteUserToCircleUseCase useCase;

  setUp(() {
    useCase = InviteUserToCircleUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.inviteUserToCircle(
        input: InviteUsersToCircleInput(
          circleId: Stubs.id,
          userIds: [Stubs.id],
        ),
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.circle),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        input: InviteUsersToCircleInput(
          circleId: Stubs.id,
          userIds: [Stubs.id],
        ),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<InviteUserToCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
