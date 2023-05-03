import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_page.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mocks.dart';

Future<void> main() async {
  late PhoneFormPage page;
  late PhoneFormInitialParams initParams;
  late PhoneFormPresentationModel model;
  late PhoneFormPresenter presenter;
  late PhoneFormNavigator navigator;

  void _initMvp({required OnboardingFlowType formType}) {
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    initParams = PhoneFormInitialParams(
      formType: formType,
      onChangedPhone: (_) => doNothing(),
      formData: const OnboardingFormData.empty(),
    );
    model = PhoneFormPresentationModel.initial(
      initParams,
      PhoneValidator(),
      UsernameValidator(),
      Mocks.featureFlagsStore,
    );
    navigator = PhoneFormNavigator(Mocks.appNavigator);
    presenter = PhoneFormPresenter(
      model,
      navigator,
      OnboardingMocks.requestPhoneCodeUseCase,
      OnboardingMocks.logInUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      OnboardingMocks.requestCodeForUsernameLoginUseCase,
    );
    page = PhoneFormPage(presenter: presenter);
  }

  await screenshotTest(
    "phone_form_page",
    variantName: "register",
    setUp: () async {
      _initMvp(formType: OnboardingFlowType.signUp);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "phone_form_page",
    variantName: "login",
    setUp: () async {
      _initMvp(formType: OnboardingFlowType.signIn);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp(formType: OnboardingFlowType.signIn);
    final page = getIt<PhoneFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
