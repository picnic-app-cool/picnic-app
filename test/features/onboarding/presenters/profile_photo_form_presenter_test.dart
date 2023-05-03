import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presenter.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late ProfilePhotoFormPresentationModel model;
  late ProfilePhotoFormPresenter presenter;
  late MockProfilePhotoFormNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = ProfilePhotoFormPresentationModel.initial(
      ProfilePhotoFormInitialParams(
        onTapContinue: (_) async => doNothing(),
        formData: const OnboardingFormData.empty(),
      ),
    );
    navigator = MockProfilePhotoFormNavigator();
    presenter = ProfilePhotoFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
