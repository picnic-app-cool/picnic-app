import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_navigator.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_page.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presenter.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mocks.dart';

Future<void> main() async {
  late MethodFormPage page;
  late MethodFormInitialParams initParams;
  late MethodFormPresentationModel model;
  late MethodFormPresenter presenter;
  late MethodFormNavigator navigator;

  void _initMvp({required OnboardingFlowType formType}) {
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    initParams = MethodFormInitialParams(
      formType: formType,
      onTapPhone: () => {},
      formData: const OnboardingFormData.empty(),
      onTapLogin: () {},
      onChangedPhone: (PhonePageResult value) {},
    );
    model = MethodFormPresentationModel.initial(
      initParams,
      PhoneValidator(),
      UsernameValidator(),
      Mocks.featureFlagsStore,
    );
    navigator = MethodFormNavigator(Mocks.appNavigator);
    presenter = MethodFormPresenter(
      model,
      navigator,
      OnboardingMocks.logInUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.environmentConfigProvider,
    );
    page = MethodFormPage(presenter: presenter);
  }

  await screenshotTest(
    "method_form_page",
    variantName: "register",
    setUp: () async {
      _initMvp(formType: OnboardingFlowType.signUp);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "method_form_page",
    variantName: "login",
    setUp: () async {
      _initMvp(formType: OnboardingFlowType.signIn);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp(formType: OnboardingFlowType.signIn);
    final page = getIt<MethodFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
