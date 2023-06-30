import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late PhoneFormPresentationModel model;
  late PhoneFormPresenter presenter;
  late MockPhoneFormNavigator navigator;

  test(
    'should enable continue button when valid phone number entered',
    () {
      presenter.onChangedCountry(Stubs.countryUS);
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
      presenter.onChangedCountry(Stubs.countryUS);
      presenter.onChangedPhone("712772813");
      presenter.onTapContinue();

      // THEN
      final captured = verify(
        () => OnboardingMocks.requestPhoneCodeUseCase.execute(verificationData: captureAny(named: "verificationData")),
      ).captured;

      final data = captured[0] as PhoneVerificationData;
      expect(data.country, Stubs.countryUS);
      expect(data.phoneNumber, "712772813");
    },
  );
  test(
    'should disable continue button when invalid phone number entered',
    () {
      presenter.onChangedPhone("+");
      expect(presenter.state.continueEnabled, isFalse);
    },
  );

  setUp(() {
    model = PhoneFormPresentationModel.initial(
      PhoneFormInitialParams(
        onChangedPhone: (result) {},
        formData: const OnboardingFormData.empty(),
      ),
      PhoneValidator(),
    );
    navigator = MockPhoneFormNavigator();
    presenter = PhoneFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
      OnboardingMocks.requestPhoneCodeUseCase,
    );
  });
}
