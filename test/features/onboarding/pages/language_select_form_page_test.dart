import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_page.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late LanguageSelectFormPage page;
  late LanguageSelectFormInitialParams initParams;
  late LanguageSelectFormPresentationModel model;
  late LanguageSelectFormPresenter presenter;
  late LanguageSelectFormNavigator navigator;

  void _initMvp() {
    initParams = LanguageSelectFormInitialParams(
      onLanguageSelected: (_) {},
      formData: const OnboardingFormData.empty(),
    );
    model = LanguageSelectFormPresentationModel.initial(
      initParams,
    );
    navigator = LanguageSelectFormNavigator(Mocks.appNavigator);
    presenter = LanguageSelectFormPresenter(
      model,
      navigator,
      Mocks.getLanguagesListUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    when(() => Mocks.getLanguagesListUseCase.execute()).thenAnswer((_) => successFuture(Stubs.languages));

    page = LanguageSelectFormPage(presenter: presenter);
  }

  await screenshotTest(
    "language_select_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<LanguageSelectFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
