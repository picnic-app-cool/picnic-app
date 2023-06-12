import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_page.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mocks.dart';

Future<void> main() async {
  late PhoneFormPage page;
  late PhoneFormInitialParams initParams;
  late PhoneFormPresentationModel model;
  late PhoneFormPresenter presenter;
  late PhoneFormNavigator navigator;

  void _initMvp() {
    initParams = PhoneFormInitialParams(
      onChangedPhone: (PhonePageResult value) {},
      formData: const OnboardingFormData.empty(),
    );
    model = PhoneFormPresentationModel.initial(
      initParams,
      PhoneValidator(),
    );
    navigator = PhoneFormNavigator(Mocks.appNavigator);
    presenter = PhoneFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
      OnboardingMocks.requestPhoneCodeUseCase,
    );
    page = PhoneFormPage(presenter: presenter);
  }

  await screenshotTest(
    "phone_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PhoneFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
