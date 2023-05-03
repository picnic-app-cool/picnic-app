import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/sign_in_with_username_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late SignInWithUsernameUseCase useCase;

  setUp(() {
    useCase = SignInWithUsernameUseCase(
      Mocks.authRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.authRepository.signInWithUsername(
          username: any(named: 'username'),
          recaptchaToken: any(named: 'recaptchaToken'),
        ),
      ).thenAnswer(
        (invocation) => successFuture(const SignInWithUsernamePayload.empty()),
      );

      // WHEN
      final result = await useCase.execute(
        username: Stubs.username,
        recaptchaToken: Stubs.recaptchaToken,
      );

      // THEN
      expect(result.isSuccess, true);
      verify(
        () => Mocks.authRepository.signInWithUsername(
          username: Stubs.username,
          recaptchaToken: Stubs.recaptchaToken,
        ),
      );
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SignInWithUsernameUseCase>();
    expect(useCase, isNotNull);
  });
}
