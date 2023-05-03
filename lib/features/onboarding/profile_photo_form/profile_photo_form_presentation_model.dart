import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ProfilePhotoFormPresentationModel implements ProfilePhotoFormViewModel {
  /// Creates the initial state
  ProfilePhotoFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ProfilePhotoFormInitialParams initialParams,
  )   : formType = initialParams.formType,
        photoPath = '',
        onTapContinueCallback = initialParams.onTapContinue,
        isLoading = false;

  /// Used for the copyWith method
  ProfilePhotoFormPresentationModel._({
    required this.formType,
    required this.onTapContinueCallback,
    required this.photoPath,
    required this.isLoading,
  });

  @override
  final ProfilePhotoFormType formType;

  final Future<void> Function(String) onTapContinueCallback;

  @override
  final String photoPath;

  @override
  final bool isLoading;

  ProfilePhotoFormPresentationModel copyWith({
    ProfilePhotoFormType? formType,
    Future<void> Function(String)? onTapContinueCallback,
    String? photoPath,
    bool? isLoading,
  }) {
    return ProfilePhotoFormPresentationModel._(
      formType: formType ?? this.formType,
      onTapContinueCallback: onTapContinueCallback ?? this.onTapContinueCallback,
      photoPath: photoPath ?? this.photoPath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ProfilePhotoFormViewModel {
  ProfilePhotoFormType get formType;

  String get photoPath;

  bool get isLoading;
}

enum ProfilePhotoFormType {
  beforePhotoSelection,
  afterPhotoSelection,
}
