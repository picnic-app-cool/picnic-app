import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/validators/age_validator.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_navigator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_page.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late AgeFormPage page;
  late AgeFormInitialParams initParams;
  late AgeFormPresentationModel model;
  late AgeFormPresenter presenter;
  late AgeFormNavigator navigator;

  void _initMvp() {
    initParams = AgeFormInitialParams(
      formData: const OnboardingFormData.empty(),
      onAgeSelected: (_) => doNothing(),
    );
    model = AgeFormPresentationModel.initial(
      initParams,
      AgeValidator(),
    );
    navigator = AgeFormNavigator(Mocks.appNavigator);
    presenter = AgeFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = AgeFormPage(presenter: presenter);
  }

  await screenshotTest(
    "age_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await configureDependenciesForTests();

    _initMvp();
    final page = getIt<AgeFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
