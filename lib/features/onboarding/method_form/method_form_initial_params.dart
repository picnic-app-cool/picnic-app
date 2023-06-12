import 'package:flutter/material.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';

class MethodFormInitialParams {
  const MethodFormInitialParams({
    required this.formType,
    required this.onChangedPhone,
    required this.formData,
    this.onTapDiscord,
    required this.onTapLogin,
    required this.onTapPhone,
  });

  final OnboardingFlowType formType;
  final OnboardingFormData formData;
  final ValueChanged<PhonePageResult> onChangedPhone;
  final VoidCallback? onTapDiscord;
  final VoidCallback onTapLogin;
  final VoidCallback onTapPhone;
}
