import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presenter.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late GenderSelectFormPresentationModel model;
  late GenderSelectFormPresenter presenter;
  late MockGenderSelectFormNavigator navigator;

  void _initMvp({bool genderSelected = false}) {
    model = GenderSelectFormPresentationModel.initial(
      GenderSelectFormInitialParams(
        onGenderSelected: (_) {},
        formData: const OnboardingFormData.empty().copyWith(
          gender: genderSelected ? "male" : "",
        ),
      ),
    );
    navigator = MockGenderSelectFormNavigator();
    presenter = GenderSelectFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  }

  test(
    'initially the continue button should be disabled when no gender is selected',
    () {
      _initMvp();
      expect(model.isContinueEnabled, false);
      expect(presenter, isNotNull);
    },
  );

  test(
    'the continue button should be enabled when the gender is selected',
    () {
      _initMvp(genderSelected: true);
      expect(model.isContinueEnabled, true);
      expect(presenter, isNotNull);
    },
  );

  test(
    'selected gender should be changed when user tapped on other gender',
    () {
      const otherGender = "other";
      _initMvp();

      presenter.onTapSelectGender(otherGender);

      expect(presenter.state.selectedGender, otherGender);
    },
  );
}
