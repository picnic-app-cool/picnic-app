import 'package:flutter/foundation.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

class AgeFormInitialParams {
  const AgeFormInitialParams({
    required this.formData,
    required this.onAgeSelected,
  });

  final OnboardingFormData formData;
  final ValueChanged<String> onAgeSelected;
}
