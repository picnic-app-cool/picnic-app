import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/unban_user_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late UnbanUserUseCase useCase;

  setUp(() {
    useCase = UnbanUserUseCase(CirclesMocks.circleModeratorActionsRepository);

    when(
      () => CirclesMocks.circleModeratorActionsRepository.unbanUser(
        circleId: Stubs.circle.id,
        userId: Stubs.user.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.user.id),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: Stubs.circle.id, userId: Stubs.user.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UnbanUserUseCase>();
    expect(useCase, isNotNull);
  });
}
