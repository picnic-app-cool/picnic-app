import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_navigator.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_page.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late CongratsFormPage page;
  late CongratsFormInitialParams initParams;
  late CongratsFormPresentationModel model;
  late CongratsFormPresenter presenter;
  late CongratsFormNavigator navigator;

  void _initMvp() {
    initParams = CongratsFormInitialParams(onTapContinue: () {});
    model = CongratsFormPresentationModel.initial(
      initParams,
    );
    navigator = CongratsFormNavigator(Mocks.appNavigator);
    presenter = CongratsFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = CongratsFormPage(presenter: presenter);
  }

  await screenshotTest(
    "congrats_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CongratsFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
