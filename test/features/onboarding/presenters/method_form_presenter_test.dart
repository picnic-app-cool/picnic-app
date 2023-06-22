import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presenter.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late MethodFormPresentationModel model;
  late MethodFormPresenter presenter;
  late MockMethodFormNavigator navigator;
  PhonePageResult? phonePageResult;

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
    model = MethodFormPresentationModel.initial(
      MethodFormInitialParams(
        formType: OnboardingFlowType.signIn,
        onTapPhone: () {},
        formData: const OnboardingFormData.empty(),
        onTapLogin: () {},
        onChangedPhone: (result) {
          phonePageResult = result;
        },
      ),
      PhoneValidator(),
      UsernameValidator(),
      Mocks.featureFlagsStore,
    );
    navigator = MockMethodFormNavigator();
    presenter = MethodFormPresenter(
      model,
      navigator,
      OnboardingMocks.logInUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.environmentConfigProvider,
    );
  });
}
