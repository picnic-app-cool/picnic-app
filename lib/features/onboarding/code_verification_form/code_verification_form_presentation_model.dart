import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/sign_in_method.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/core/validators/verification_code_validator.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/username_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_code_for_username_login_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CodeVerificationFormPresentationModel implements CodeVerificationFormViewModel {
  /// Creates the initial state
  CodeVerificationFormPresentationModel.initial(
    CodeVerificationFormInitialParams initialParams,
    this.verificationCodeValidator,
    this.currentTimeProvider,
  )   : verificationData = initialParams.formData.phoneVerificationData,
        sendCodeTime = currentTimeProvider.currentTime,
        onCodeVerifiedCallback = initialParams.onCodeVerified,
        codeVerificationResult = const FutureResult.empty(),
        requestCodeResult = const FutureResult.empty(),
        requestUsernameCodeResult = const FutureResult.empty(),
        usernameVerificationData = initialParams.formData.usernameVerificationData,
        isUsernameLogin = initialParams.formData.usernameVerificationData != const UsernameVerificationData.empty();

  /// Used for the copyWith method
  CodeVerificationFormPresentationModel._({
    required this.verificationCodeValidator,
    required this.onCodeVerifiedCallback,
    required this.codeVerificationResult,
    required this.currentTimeProvider,
    required this.sendCodeTime,
    required this.verificationData,
    required this.requestCodeResult,
    required this.usernameVerificationData,
    required this.requestUsernameCodeResult,
    required this.isUsernameLogin,
  });

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final bool isUsernameLogin;

  final VerificationCodeValidator verificationCodeValidator;
  final ValueChanged<AuthResult> onCodeVerifiedCallback;
  final FutureResult<Either<LogInFailure, AuthResult>> codeVerificationResult;
  final FutureResult<Either<RequestPhoneCodeFailure, PhoneVerificationData>> requestCodeResult;
  final FutureResult<Either<RequestCodeForUsernameLoginFailure, UsernameVerificationData>> requestUsernameCodeResult;
  final PhoneVerificationData verificationData;
  final UsernameVerificationData usernameVerificationData;

  /// moment in time at which the verification code was sent
  final DateTime sendCodeTime;

  @override
  bool get continueEnabled => codeVerificationResult.result?.isSuccess ?? false;

  @override
  String get errorMessage => (codeVerificationResult.result?.isFailure ?? false) //
      ? appLocalizations.codeVerificationError
      : '';

  @override
  bool get isLoading => codeVerificationResult.isPending();

  bool get isCodeLengthValid => verificationCodeValidator.validate(code).isSuccess;

  @override
  int get codeLength => VerificationCodeValidator.codeLength;

  @override
  bool get isError => codeVerificationResult.result?.isFailure ?? false;

  @override
  DateTime get codeExpiryTime => sendCodeTime.add(const Duration(seconds: 30));

  @override
  String get code => isUsernameLogin ? usernameVerificationData.code : verificationData.smsCode;

  @override
  String get maskedIdentifier => usernameVerificationData.signInWithUsernamePayload.maskedIdentifier;

  @override
  SignInMethod get signInMethod => usernameVerificationData.signInWithUsernamePayload.signInMethod;

  LogInCredentials get logInCredentials {
    if (isUsernameLogin) {
      return UsernameLogInCredentials(usernameVerificationData);
    }
    return PhoneLogInCredentials(verificationData);
  }

  CodeVerificationFormPresentationModel byResettingTimer({
    required PhoneVerificationData verificationData,
    required UsernameVerificationData usernameVerificationData,
  }) =>
      copyWith(
        sendCodeTime: currentTimeProvider.currentTime,
        verificationData: verificationData,
        usernameVerificationData: usernameVerificationData,
      );

  CodeVerificationFormPresentationModel copyWith({
    CurrentTimeProvider? currentTimeProvider,
    VerificationCodeValidator? verificationCodeValidator,
    ValueChanged<AuthResult>? onCodeVerifiedCallback,
    FutureResult<Either<LogInFailure, AuthResult>>? codeVerificationResult,
    FutureResult<Either<RequestPhoneCodeFailure, PhoneVerificationData>>? requestCodeResult,
    FutureResult<Either<RequestCodeForUsernameLoginFailure, UsernameVerificationData>>? requestUsernameCodeResult,
    PhoneVerificationData? verificationData,
    UsernameVerificationData? usernameVerificationData,
    DateTime? sendCodeTime,
    bool? isUsernameLogin,
  }) {
    return CodeVerificationFormPresentationModel._(
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      verificationCodeValidator: verificationCodeValidator ?? this.verificationCodeValidator,
      onCodeVerifiedCallback: onCodeVerifiedCallback ?? this.onCodeVerifiedCallback,
      codeVerificationResult: codeVerificationResult ?? this.codeVerificationResult,
      requestCodeResult: requestCodeResult ?? this.requestCodeResult,
      verificationData: verificationData ?? this.verificationData,
      sendCodeTime: sendCodeTime ?? this.sendCodeTime,
      usernameVerificationData: usernameVerificationData ?? this.usernameVerificationData,
      requestUsernameCodeResult: requestUsernameCodeResult ?? this.requestUsernameCodeResult,
      isUsernameLogin: isUsernameLogin ?? this.isUsernameLogin,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CodeVerificationFormViewModel {
  int get codeLength;

  bool get isError;

  String get errorMessage;

  bool get continueEnabled;

  bool get isLoading;

  DateTime get codeExpiryTime;

  CurrentTimeProvider get currentTimeProvider;

  String get code;

  bool get isUsernameLogin;

  String get maskedIdentifier;

  SignInMethod get signInMethod;
}
