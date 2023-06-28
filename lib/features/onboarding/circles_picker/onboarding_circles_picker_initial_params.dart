import 'package:flutter/widgets.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

class OnBoardingCirclesPickerInitialParams {
  const OnBoardingCirclesPickerInitialParams({
    required this.onCirclesSelected,
    required this.formData,
  });

  final OnboardingFormData formData;
  final ValueChanged<List<Id>> onCirclesSelected;
}
