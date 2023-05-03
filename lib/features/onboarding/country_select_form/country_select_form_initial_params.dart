import 'package:flutter/widgets.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

class CountrySelectFormInitialParams {
  const CountrySelectFormInitialParams({
    required this.onCountrySelected,
    required this.formData,
  });

  final OnboardingFormData formData;
  final ValueChanged<String> onCountrySelected;
}
