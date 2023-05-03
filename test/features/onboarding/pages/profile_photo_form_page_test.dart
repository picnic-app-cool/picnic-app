import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_navigator.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_page.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late ProfilePhotoFormPage page;
  late ProfilePhotoFormInitialParams initParams;
  late ProfilePhotoFormPresentationModel model;
  late ProfilePhotoFormPresenter presenter;
  late ProfilePhotoFormNavigator navigator;

  void _initMvp() {
    initParams = ProfilePhotoFormInitialParams(
      onTapContinue: (_) async => doNothing(),
      formData: const OnboardingFormData.empty(),
    );
    model = ProfilePhotoFormPresentationModel.initial(
      initParams,
    );
    navigator = ProfilePhotoFormNavigator(Mocks.appNavigator);
    presenter = ProfilePhotoFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = ProfilePhotoFormPage(presenter: presenter);
  }

  await screenshotTest(
    "profile_photo_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ProfilePhotoFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
