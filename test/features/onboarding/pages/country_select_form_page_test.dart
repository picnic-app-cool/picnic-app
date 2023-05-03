import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_page.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late CountrySelectFormPage page;
  late CountrySelectFormInitialParams initParams;
  late CountrySelectFormPresentationModel model;
  late CountrySelectFormPresenter presenter;
  late CountrySelectFormNavigator navigator;

  void _initMvp() {
    initParams = CountrySelectFormInitialParams(
      onCountrySelected: (_) {},
      formData: const OnboardingFormData.empty(),
    );
    model = CountrySelectFormPresentationModel.initial(
      initParams,
    );
    navigator = CountrySelectFormNavigator(Mocks.appNavigator);
    presenter = CountrySelectFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = CountrySelectFormPage(presenter: presenter);
  }

  await screenshotTest(
    "country_select_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CountrySelectFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
