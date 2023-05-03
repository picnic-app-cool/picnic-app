import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';

class ProfilePhotoFormInitialParams {
  const ProfilePhotoFormInitialParams({
    this.formType = ProfilePhotoFormType.beforePhotoSelection,
    required this.formData,
    required this.onTapContinue,
  });

  final ProfilePhotoFormType formType;

  final Future<void> Function(String) onTapContinue;

  final OnboardingFormData formData;
}
