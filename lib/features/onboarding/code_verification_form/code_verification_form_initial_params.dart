import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

class CodeVerificationFormInitialParams {
  const CodeVerificationFormInitialParams({
    required this.onCodeVerified,
    required this.formData,
  });

  final ValueChanged<AuthResult> onCodeVerified;
  final OnboardingFormData formData;
}
