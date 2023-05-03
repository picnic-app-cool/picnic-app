import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';

class UsernameFormInitialParams {
  const UsernameFormInitialParams({
    required this.onUsernameSelected,
    required this.formData,
  });

  final OnboardingFormData formData;
  final UsernameSelectedCallback onUsernameSelected;
}
