import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_code_for_username_login_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class MethodFormPresentationModel implements MethodFormViewModel {
  /// Creates the initial state
  MethodFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    MethodFormInitialParams initialParams,
    this.phoneValidator,
    this.usernameValidator,
    FeatureFlagsStore featureFlagStore,
  )   : formType = initialParams.formType,
        onChangedPhoneCallback = initialParams.onChangedPhone,
        onDiscordCallback = initialParams.onTapDiscord,
        onPhoneCallback = initialParams.onTapPhone,
        onTapLoginCallback = initialParams.onTapLogin,
        verificationData = initialParams.formData.phoneVerificationData,
        usernameVerificationData = initialParams.formData.usernameVerificationData,
        phoneCodeFutureResult = const FutureResult.empty(),
        socialLoginFutureResult = const FutureResult.empty(),
        usernameCodeFutureResult = const FutureResult.empty(),
        featureFlags = featureFlagStore.featureFlags,
        isUsernameAuthOpened = false,
        username = '';

  /// Used for the copyWith method
  MethodFormPresentationModel._({
    required this.formType,
    required this.phoneValidator,
    required this.usernameValidator,
    required this.onChangedPhoneCallback,
    required this.onPhoneCallback,
    required this.phoneCodeFutureResult,
    required this.verificationData,
    required this.usernameVerificationData,
    required this.socialLoginFutureResult,
    required this.usernameCodeFutureResult,
    required this.featureFlags,
    required this.isUsernameAuthOpened,
    required this.username,
    required this.onDiscordCallback,
    required this.onTapLoginCallback,
  });

  @override
  final OnboardingFlowType formType;
  final PhoneValidator phoneValidator;
  final UsernameValidator usernameValidator;
  final ValueChanged<PhonePageResult> onChangedPhoneCallback;
  final VoidCallback? onDiscordCallback;

  final VoidCallback onPhoneCallback;

  final FutureResult<Either<RequestPhoneCodeFailure, PhoneVerificationData>> phoneCodeFutureResult;
  final FutureResult<Either<LogInFailure, AuthResult>> socialLoginFutureResult;
  final FutureResult<Either<RequestCodeForUsernameLoginFailure, UsernameVerificationData>> usernameCodeFutureResult;
  final PhoneVerificationData verificationData;
  final UsernameVerificationData usernameVerificationData;
  final FeatureFlags featureFlags;
  final VoidCallback onTapLoginCallback;

  @override
  final String username;

  @override
  final bool isUsernameAuthOpened;

  @override
  bool get isFirebasePhoneAuthEnabled => featureFlags[FeatureFlagType.isFirebasePhoneAuthEnabled];

  String get fullPhone => verificationData.phoneNumberWithDialCode;

  String get phone => verificationData.phoneNumber;

  bool get isPhoneValid => phoneValidator.validate(fullPhone).isSuccess;

  bool get isUsernameValid => usernameValidator.validate(username).isSuccess;

  bool get isPhoneContinueEnabled => !isUsernameAuthOpened && isPhoneValid;

  bool get isUsernameContinueEnabled => isUsernameAuthOpened && isUsernameValid;

  @override
  bool get continueEnabled => (isPhoneContinueEnabled || isUsernameContinueEnabled) && !isLoading;

  @override
  bool get isLoading =>
      phoneCodeFutureResult.isPending() || socialLoginFutureResult.isPending() || usernameCodeFutureResult.isPending();

  @override
  String get phoneNumber => verificationData.phoneNumber;

  @override
  String get dialCode => verificationData.dialCode;

  @override
  bool get signInWithGoogleEnabled => featureFlags[FeatureFlagType.signInWithGoogleEnabled];

  @override
  bool get signInWithDiscordEnabled => featureFlags[FeatureFlagType.signInWithDiscordEnabled];

  @override
  bool get signInWithAppleEnabled => featureFlags[FeatureFlagType.signInWithAppleEnabled];

  @override
  bool get showSignInWithUsername => isFirebasePhoneAuthEnabled && formType == OnboardingFlowType.signIn;

  MethodFormPresentationModel byUpdatingVerificationData(
    PhoneVerificationData Function(PhoneVerificationData) mapper,
  ) =>
      copyWith(
        verificationData: mapper(verificationData),
      );

  MethodFormPresentationModel copyWith({
    OnboardingFlowType? formType,
    PhoneValidator? phoneValidator,
    UsernameValidator? usernameValidator,
    ValueChanged<PhonePageResult>? onChangedPhoneCallback,
    VoidCallback? onPhoneCallback,
    FutureResult<Either<RequestPhoneCodeFailure, PhoneVerificationData>>? phoneCodeFutureResult,
    FutureResult<Either<LogInFailure, AuthResult>>? socialLoginFutureResult,
    FutureResult<Either<RequestCodeForUsernameLoginFailure, UsernameVerificationData>>? usernameCodeFutureResult,
    PhoneVerificationData? verificationData,
    UsernameVerificationData? usernameVerificationData,
    bool? isUsernameAuthOpened,
    String? username,
    VoidCallback? onDiscordCallback,
    VoidCallback? onTapLoginCallback,
  }) {
    return MethodFormPresentationModel._(
      formType: formType ?? this.formType,
      phoneValidator: phoneValidator ?? this.phoneValidator,
      usernameValidator: usernameValidator ?? this.usernameValidator,
      onChangedPhoneCallback: onChangedPhoneCallback ?? this.onChangedPhoneCallback,
      onPhoneCallback: onPhoneCallback ?? this.onPhoneCallback,
      phoneCodeFutureResult: phoneCodeFutureResult ?? this.phoneCodeFutureResult,
      socialLoginFutureResult: socialLoginFutureResult ?? this.socialLoginFutureResult,
      usernameCodeFutureResult: usernameCodeFutureResult ?? this.usernameCodeFutureResult,
      verificationData: verificationData ?? this.verificationData,
      usernameVerificationData: usernameVerificationData ?? this.usernameVerificationData,
      featureFlags: featureFlags,
      isUsernameAuthOpened: isUsernameAuthOpened ?? this.isUsernameAuthOpened,
      username: username ?? this.username,
      onDiscordCallback: onDiscordCallback ?? this.onDiscordCallback,
      onTapLoginCallback: onTapLoginCallback ?? this.onTapLoginCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class MethodFormViewModel {
  bool get continueEnabled;

  bool get isLoading;

  OnboardingFlowType get formType;

  String get phoneNumber;

  String get username;

  String get dialCode;

  bool get isFirebasePhoneAuthEnabled;

  bool get signInWithGoogleEnabled;

  bool get signInWithDiscordEnabled;

  bool get signInWithAppleEnabled;

  bool get isUsernameAuthOpened;

  bool get showSignInWithUsername;
}
