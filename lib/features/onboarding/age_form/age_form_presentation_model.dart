import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/core/validators/age_validator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AgeFormPresentationModel implements AgeFormViewModel {
  /// Creates the initial state
  AgeFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AgeFormInitialParams initialParams,
    this.ageValidator,
  )   : onAgeSelectedCallback = initialParams.onAgeSelected,
        ageText = initialParams.formData.age;

  /// Used for the copyWith method
  AgeFormPresentationModel._({
    required this.onAgeSelectedCallback,
    required this.ageText,
    required this.ageValidator,
  });

  final AgeValidator ageValidator;

  final ValueChanged<String> onAgeSelectedCallback;
  @override
  final String ageText;

  @override
  bool get continueEnabled => ageValidator.validate(ageText).isSuccess;

  @override
  String get ageErrorText {
    if (ageText.isEmpty) {
      return '';
    }
    final validationError = ageValidator.validate(ageText).getFailure();
    switch (validationError?.type) {
      case AgeValidationErrorType.tooYoung:
        return appLocalizations.ageTooYoungError;
      case AgeValidationErrorType.invalidInput:
        return appLocalizations.invalidInputError;
      case null:
        return '';
    }
  }

  AgeFormPresentationModel copyWith({
    AgeValidator? ageValidator,
    ValueChanged<String>? onTapContinueCallback,
    String? ageText,
  }) {
    return AgeFormPresentationModel._(
      ageValidator: ageValidator ?? this.ageValidator,
      onAgeSelectedCallback: onTapContinueCallback ?? onAgeSelectedCallback,
      ageText: ageText ?? this.ageText,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AgeFormViewModel {
  bool get continueEnabled;

  String get ageErrorText;

  String get ageText;
}
