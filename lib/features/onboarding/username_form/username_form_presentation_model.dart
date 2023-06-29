import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/check_username_availability_failure.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

typedef UsernameSelectedCallback = Future<void> Function(String username);

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class UsernameFormPresentationModel implements UsernameFormViewModel {
  /// Creates the initial state
  UsernameFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    UsernameFormInitialParams initialParams,
    this.usernameValidator,
  )   : onUsernameSelectedCallback = initialParams.onUsernameSelected,
        username = initialParams.formData.username,
        usernameSelectedResult = const FutureResult.empty(),
        usernameCheckResult = const FutureResult.empty();

  /// Used for the copyWith method
  UsernameFormPresentationModel._({
    required this.onUsernameSelectedCallback,
    required this.username,
    required this.usernameCheckResult,
    required this.usernameSelectedResult,
    required this.usernameValidator,
  });

  final UsernameValidator usernameValidator;

  final UsernameSelectedCallback onUsernameSelectedCallback;
  @override
  final String username;
  final FutureResult<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>> usernameCheckResult;
  final FutureResult<void> usernameSelectedResult;

  @override
  bool get continueEnabled => !isLoading && !isTaken && usernameValidator.validate(username).isSuccess;

  @override
  bool get isLoading => usernameCheckResult.isPending() || usernameSelectedResult.isPending();

  @override
  String get usernameErrorText {
    if (usernameCheckResult.isNotStarted) {
      return '';
    }
    if (isTaken) {
      return appLocalizations.usernameTakenErrorMessage;
    }
    return usernameValidator.validate(username).getFailure()?.errorText ?? '';
  }

  bool get isTaken => _usernameCheckResult?.isTaken ?? false;

  @override
  bool get containsSpaces =>
      usernameValidator.validate(username).getFailure()?.type == UsernameValidationErrorType.containsSpaces;

  UsernameCheckResult? get _usernameCheckResult => usernameCheckResult.result?.getSuccess();

  UsernameFormPresentationModel copyWith({
    UsernameValidator? usernameValidator,
    UsernameSelectedCallback? onUsernameSelectedCallback,
    String? username,
    FutureResult<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>>? usernameCheckResult,
    FutureResult<void>? usernameSelectedResult,
  }) {
    return UsernameFormPresentationModel._(
      usernameValidator: usernameValidator ?? this.usernameValidator,
      onUsernameSelectedCallback: onUsernameSelectedCallback ?? this.onUsernameSelectedCallback,
      username: username ?? this.username,
      usernameCheckResult: usernameCheckResult ?? this.usernameCheckResult,
      usernameSelectedResult: usernameSelectedResult ?? this.usernameSelectedResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class UsernameFormViewModel {
  bool get continueEnabled;

  bool get isLoading;

  bool get containsSpaces;

  String get username;

  String get usernameErrorText;
}
