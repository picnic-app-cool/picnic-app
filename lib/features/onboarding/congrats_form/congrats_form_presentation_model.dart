import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CongratsFormPresentationModel implements CongratsFormViewModel {
  /// Creates the initial state
  CongratsFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CongratsFormInitialParams initialParams,
  ) : onTapContinueCallback = initialParams.onTapContinue;

  /// Used for the copyWith method
  CongratsFormPresentationModel._({
    required this.onTapContinueCallback,
  });

  final VoidCallback onTapContinueCallback;

  CongratsFormPresentationModel copyWith({
    VoidCallback? onTapContinueCallback,
  }) {
    return CongratsFormPresentationModel._(
      onTapContinueCallback: onTapContinueCallback ?? this.onTapContinueCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CongratsFormViewModel {}
