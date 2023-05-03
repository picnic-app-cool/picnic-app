import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late CodeVerificationFormPresentationModel model;
  late CodeVerificationFormPresenter presenter;
  late MockCodeVerificationFormNavigator navigator;

  AuthResult? authResult;

  test(
    'should execute Code verification useCase',
    () {
      // GIVEN
      when(() => OnboardingMocks.logInUseCase.execute(any()))
          .thenAnswer((invocation) => successFuture(const AuthResult.empty()));

      // WHEN
      presenter.onChangedCode("123456");
      presenter.onTapContinue();

      // THEN
      final captured = verify(
        () => OnboardingMocks.logInUseCase.execute(captureAny()),
      ).captured;

      final data = captured[0] as PhoneLogInCredentials;
      expect(data.verificationData.smsCode, "123456");
    },
  );

  test(
    'should call onCodeVerified with userId in case user is not found to trigger sign up flow',
    () async {
      const userId = 'user-id';
      // GIVEN
      when(() => OnboardingMocks.logInUseCase.execute(any())) //
          .thenFailure((p0) {
        return const LogInFailure.userNotFound('cause', Id(userId));
      });
      // WHEN
      await presenter.onChangedCode('123456');

      // THEN
      expect(authResult, isNotNull);
      expect(authResult?.passedOnboarding, false);
      // we need to return user id so that auth flow recognizes it should use sign up
      expect(authResult?.userId.value, userId);
    },
  );

  test(
    "typing in code and tapping multiple 'continue' buttons trigger only one request",
    () => fakeAsync((async) {
      reset(OnboardingMocks.logInUseCase);
      final completer = Completer<Either<LogInFailure, AuthResult>>();
      when(() => OnboardingMocks.logInUseCase.execute(any())) //
          .thenAnswer((_) => completer.future);
      unawaited(presenter.onChangedCode('123456'));
      async.elapse(const Duration(milliseconds: 50));
      unawaited(presenter.onChangedCode('7654321'));
      async.elapse(const Duration(milliseconds: 4050));
      unawaited(presenter.onChangedCode('654321'));
      async.elapse(const Duration(milliseconds: 50));
      unawaited(presenter.onTapContinue());
      async.elapse(const Duration(milliseconds: 50));
      unawaited(presenter.onTapContinue());
      async.elapse(const Duration(milliseconds: 50));
      completer.complete(success(Stubs.authResult));
      verify(() => OnboardingMocks.logInUseCase.execute(any())).called(1);
    }),
  );

  setUp(() {
    when(() => Mocks.throttler.throttle<Future<void>>(any(), any())).thenAnswer((invocation) {
      return (invocation.positionalArguments[1] as Future<void> Function()).call();
    });
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8));
    model = CodeVerificationFormPresentationModel.initial(
      CodeVerificationFormInitialParams(
        onCodeVerified: (result) => authResult = result,
        formData: const OnboardingFormData.empty(),
      ),
      getIt(),
      Mocks.currentTimeProvider,
    );
    navigator = MockCodeVerificationFormNavigator();
    presenter = CodeVerificationFormPresenter(
      model,
      navigator,
      OnboardingMocks.logInUseCase,
      OnboardingMocks.requestPhoneCodeUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      OnboardingMocks.requestCodeForUsernameLoginUseCase,
      Throttler(),
    );
  });
}
