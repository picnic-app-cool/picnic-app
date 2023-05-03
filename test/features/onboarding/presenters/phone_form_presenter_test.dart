import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late PhoneFormPresentationModel model;
  late PhoneFormPresenter presenter;
  late MockPhoneFormNavigator navigator;
  PhonePageResult? phonePageResult;

  test(
    'should disable continue button when invalid phone number entered',
    () {
      presenter.onChangedPhone("+");
      expect(presenter.state.continueEnabled, isFalse);
    },
  );

  test(
    'should enable continue button when valid phone number entered',
    () {
      presenter.onChangedDialCode("+48");
      presenter.onChangedPhone("712772813");
      expect(presenter.state.continueEnabled, isTrue);
    },
  );

  test(
    'should execute Phone verification useCase',
    () {
      // GIVEN
      when(() => OnboardingMocks.requestPhoneCodeUseCase.execute(verificationData: any(named: "verificationData")))
          .thenAnswer((invocation) => successFuture(const PhoneVerificationData.empty()));

      // WHEN
      presenter.onChangedDialCode("+48");
      presenter.onChangedPhone("712772813");
      presenter.onTapContinue();

      // THEN
      final captured = verify(
        () => OnboardingMocks.requestPhoneCodeUseCase.execute(verificationData: captureAny(named: "verificationData")),
      ).captured;

      final data = captured[0] as PhoneVerificationData;
      expect(data.dialCode, "+48");
      expect(data.phoneNumber, "712772813");
    },
  );

  test(
    'should return empty auth result in case user is not found to trigger sign up flow',
    () async {
      // GIVEN
      when(() => OnboardingMocks.logInUseCase.execute(any())).thenFailure((p0) => const LogInFailure.userNotFound());
      // WHEN
      await presenter.onTapGoogleLogIn();

      // THEN
      expect(phonePageResult?.authResult, isNotNull);
      expect(phonePageResult?.authResult?.passedOnboarding, false);
    },
  );

  test(
    'should use userId returned in userNotFound error to build authResult',
    () async {
      // GIVEN
      const firebaseId = 'firebase-id';
      when(() => OnboardingMocks.logInUseCase.execute(any()))
          .thenFailure((p0) => const LogInFailure.userNotFound("cause", Id(firebaseId)));
      // WHEN
      await presenter.onTapGoogleLogIn();

      // THEN
      // we need to return user id so that auth flow recognizes it should use sign up
      expect(phonePageResult!.authResult!.userId.value, firebaseId);
    },
  );

  setUp(() {
    phonePageResult = null;
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    model = PhoneFormPresentationModel.initial(
      PhoneFormInitialParams(
        formType: OnboardingFlowType.signIn,
        onChangedPhone: (result) {
          phonePageResult = result;
        },
        formData: const OnboardingFormData.empty(),
      ),
      PhoneValidator(),
      UsernameValidator(),
      Mocks.featureFlagsStore,
    );
    navigator = MockPhoneFormNavigator();
    presenter = PhoneFormPresenter(
      model,
      navigator,
      OnboardingMocks.requestPhoneCodeUseCase,
      OnboardingMocks.logInUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      OnboardingMocks.requestCodeForUsernameLoginUseCase,
    );
  });
}
