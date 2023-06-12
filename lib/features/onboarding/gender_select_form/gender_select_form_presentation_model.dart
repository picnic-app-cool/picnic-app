import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class GenderSelectFormPresentationModel implements GenderSelectFormViewModel {
  /// Creates the initial state
  GenderSelectFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    GenderSelectFormInitialParams initialParams,
  )   : onGenderSelectedCallback = initialParams.onGenderSelected,
        selectedGender = initialParams.formData.gender;

  /// Used for the copyWith method
  GenderSelectFormPresentationModel._({
    required this.onGenderSelectedCallback,
    required this.selectedGender,
  });

  @override
  final String selectedGender;
  final ValueChanged<String> onGenderSelectedCallback;

  @override
  bool get isContinueEnabled => selectedGender.isNotEmpty;

  @override
  List<String> get genders => [
        "female",
        "male",
        "non-binary",
        "prefer not to say",
      ];

  GenderSelectFormPresentationModel copyWith({
    String? selectedGender,
    ValueChanged<String>? onGenderSelectedCallback,
  }) {
    return GenderSelectFormPresentationModel._(
      selectedGender: selectedGender ?? this.selectedGender,
      onGenderSelectedCallback: onGenderSelectedCallback ?? this.onGenderSelectedCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class GenderSelectFormViewModel {
  bool get isContinueEnabled;

  List<String> get genders;

  String get selectedGender;
}
