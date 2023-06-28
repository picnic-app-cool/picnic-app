import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/onboarding/domain/model/gender.dart';
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
  final Gender selectedGender;
  final ValueChanged<Gender> onGenderSelectedCallback;

  @override
  bool get isContinueEnabled => selectedGender != Gender.unknown;

  @override
  List<Gender> get genders => [
        Gender.female,
        Gender.male,
        Gender.nonBinary,
        Gender.preferNotToSay,
      ];

  GenderSelectFormPresentationModel copyWith({
    Gender? selectedGender,
    ValueChanged<Gender>? onGenderSelectedCallback,
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

  List<Gender> get genders;

  Gender get selectedGender;
}
