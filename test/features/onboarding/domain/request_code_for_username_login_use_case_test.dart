import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/sign_in_captcha_params.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_code_for_username_login_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late RequestCodeForUsernameLoginUseCase useCase;

  setUp(() {
    useCase = RequestCodeForUsernameLoginUseCase(
      OnboardingMocks.getCaptchaParamsUseCase,
      Mocks.recaptchaVerificationUseCase,
      OnboardingMocks.signInWithUsernameUseCase,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => OnboardingMocks.getCaptchaParamsUseCase.execute(),
      ).thenAnswer(
        (invocation) => successFuture(
          SignInCaptchaParams(recaptchaSiteKey: Stubs.recaptchaSiteKey),
        ),
      );

      when(
        () => Mocks.recaptchaVerificationUseCase.execute(
          siteKey: any(named: 'siteKey'),
        ),
      ).thenAnswer(
        (invocation) => successFuture(Stubs.recaptchaToken),
      );

      when(
        () => OnboardingMocks.signInWithUsernameUseCase.execute(
          username: any(named: 'username'),
          recaptchaToken: any(named: 'recaptchaToken'),
        ),
      ).thenAnswer(
        (invocation) => successFuture(
          const SignInWithUsernamePayload.empty(),
        ),
      );

      // WHEN
      final result = await useCase.execute(username: Stubs.username);

      // THEN
      expect(result.isSuccess, true);
      verify(() => OnboardingMocks.getCaptchaParamsUseCase.execute());
      verify(
        () => Mocks.recaptchaVerificationUseCase.execute(siteKey: Stubs.recaptchaSiteKey),
      );
      verify(
        () => OnboardingMocks.signInWithUsernameUseCase.execute(
          username: Stubs.username,
          recaptchaToken: Stubs.recaptchaToken,
        ),
      );
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RequestCodeForUsernameLoginUseCase>();
    expect(useCase, isNotNull);
  });
}
