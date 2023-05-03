import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

class LanguageSelectFormInitialParams {
  const LanguageSelectFormInitialParams({
    required this.formData,
    required this.onLanguageSelected,
  });

  final OnboardingFormData formData;
  final ValueChanged<Language> onLanguageSelected;
}
