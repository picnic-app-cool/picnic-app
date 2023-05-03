import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/sign_in_captcha_params.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_captcha_params_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCaptchaParamsUseCase useCase;

  setUp(() {
    useCase = GetCaptchaParamsUseCase(
      Mocks.authRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.authRepository.getCaptchaParams(),
      ).thenAnswer(
        (invocation) => successFuture(const SignInCaptchaParams.empty()),
      );

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
      verify(() => Mocks.authRepository.getCaptchaParams());
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCaptchaParamsUseCase>();
    expect(useCase, isNotNull);
  });
}
