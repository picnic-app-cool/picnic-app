import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_page.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late GenderSelectFormPage page;
  late GenderSelectFormInitialParams initParams;
  late GenderSelectFormPresentationModel model;
  late GenderSelectFormPresenter presenter;
  late GenderSelectFormNavigator navigator;

  void _initMvp() {
    initParams = GenderSelectFormInitialParams(
      onGenderSelected: (_) {},
      formData: const OnboardingFormData.empty(),
    );
    model = GenderSelectFormPresentationModel.initial(
      initParams,
    );
    navigator = GenderSelectFormNavigator(Mocks.appNavigator);
    presenter = GenderSelectFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    page = GenderSelectFormPage(presenter: presenter);
  }

  await screenshotTest(
    "gender_select_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<GenderSelectFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
