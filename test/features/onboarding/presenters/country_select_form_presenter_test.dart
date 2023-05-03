import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late CountrySelectFormPresentationModel model;
  late CountrySelectFormPresenter presenter;
  late MockCountrySelectFormNavigator navigator;

  test(
    'initial country code should be the same as in the intial params',
    () {
      expect(presenter.state.countryCode, 'US');
    },
  );

  test(
    'selected country should be changed when user tapped on other country',
    () {
      const otherCountry = 'Other';

      presenter.onChangedCountryCode(otherCountry);

      expect(presenter.state.countryCode, otherCountry);
    },
  );

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    final initParams = CountrySelectFormInitialParams(
      onCountrySelected: (_) {},
      formData: const OnboardingFormData.empty().copyWith(country: 'US'),
    );
    model = CountrySelectFormPresentationModel.initial(
      initParams,
    );
    navigator = MockCountrySelectFormNavigator();
    presenter = CountrySelectFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
