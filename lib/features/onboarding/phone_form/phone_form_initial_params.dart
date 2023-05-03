import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';

class PhoneFormInitialParams {
  const PhoneFormInitialParams({
    required this.formType,
    required this.onChangedPhone,
    required this.formData,
    this.onTapDiscord,
  });

  final OnboardingFlowType formType;
  final OnboardingFormData formData;
  final ValueChanged<PhonePageResult> onChangedPhone;
  final VoidCallback? onTapDiscord;
}

class PhonePageResult {
  const PhonePageResult({
    this.phoneVerificationData,
    this.authResult,
    this.usernameVerificationData,
  });

  /// returned if user phone veriifcation
  final PhoneVerificationData? phoneVerificationData;

  /// returned for social logins
  final AuthResult? authResult;

  /// returned when user logs in with username
  final UsernameVerificationData? usernameVerificationData;
}
