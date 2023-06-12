import 'package:flutter/widgets.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

class GenderSelectFormInitialParams {
  const GenderSelectFormInitialParams({
    required this.formData,
    required this.onGenderSelected,
  });

  final OnboardingFormData formData;
  final ValueChanged<String> onGenderSelected;
}
