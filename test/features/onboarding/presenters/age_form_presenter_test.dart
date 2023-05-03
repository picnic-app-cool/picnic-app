import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/validators/age_validator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late AgeFormPresentationModel model;
  late AgeFormPresenter presenter;
  late MockAgeFormNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter.navigator, isNotNull);
      expect(presenter.state, model);
    },
  );

  setUp(() {
    model = AgeFormPresentationModel.initial(
      AgeFormInitialParams(
        onAgeSelected: (_) => doNothing(),
        formData: const OnboardingFormData.empty(),
      ),
      AgeValidator(),
    );
    navigator = MockAgeFormNavigator();
    presenter = AgeFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
