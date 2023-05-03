import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_navigator.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_page.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mocks.dart';

Future<void> main() async {
  late CodeVerificationFormPage page;
  late CodeVerificationFormInitialParams initParams;
  late CodeVerificationFormPresentationModel model;
  late CodeVerificationFormPresenter presenter;
  late CodeVerificationFormNavigator navigator;

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8));
    initParams = CodeVerificationFormInitialParams(
      formData: const OnboardingFormData.empty(),
      onCodeVerified: (_) => doNothing(),
    );
    model = CodeVerificationFormPresentationModel.initial(
      initParams,
      getIt(),
      Mocks.currentTimeProvider,
    );
    navigator = CodeVerificationFormNavigator(Mocks.appNavigator);
    presenter = CodeVerificationFormPresenter(
      model,
      navigator,
      OnboardingMocks.logInUseCase,
      OnboardingMocks.requestPhoneCodeUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      OnboardingMocks.requestCodeForUsernameLoginUseCase,
      Mocks.throttler,
    );
    page = CodeVerificationFormPage(presenter: presenter);
  }

  await screenshotTest(
    "code_verification_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CodeVerificationFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
