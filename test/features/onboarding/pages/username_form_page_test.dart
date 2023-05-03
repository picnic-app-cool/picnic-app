import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_navigator.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_page.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late UsernameFormPage page;
  late UsernameFormInitialParams initParams;
  late UsernameFormPresentationModel model;
  late UsernameFormPresenter presenter;
  late UsernameFormNavigator navigator;

  void _initMvp() {
    initParams = UsernameFormInitialParams(
      onUsernameSelected: (_) async => doNothing(),
      formData: const OnboardingFormData.empty(),
    );
    model = UsernameFormPresentationModel.initial(
      initParams,
      UsernameValidator(),
    );
    navigator = UsernameFormNavigator(Mocks.appNavigator);
    presenter = UsernameFormPresenter(
      model,
      navigator,
      Mocks.debouncer,
      Mocks.throttler,
      Mocks.checkUsernameAvailabilityUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = UsernameFormPage(presenter: presenter);
  }

  await screenshotTest(
    "username_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<UsernameFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
