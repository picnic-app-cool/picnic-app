import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PhoneFormPresentationModel implements CongratsFormViewModel {
  /// Creates the initial state
  PhoneFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PhoneFormInitialParams initialParams,
    this.phoneValidator,
  )   : phoneCodeFutureResult = const FutureResult.empty(),
        onChangedPhoneCallback = initialParams.onChangedPhone,
        verificationData = initialParams.formData.phoneVerificationData;

  /// Used for the copyWith method
  PhoneFormPresentationModel._({
    required this.verificationData,
    required this.phoneValidator,
    required this.phoneCodeFutureResult,
    required this.onChangedPhoneCallback,
  });

  final PhoneValidator phoneValidator;
  final FutureResult<Either<RequestPhoneCodeFailure, PhoneVerificationData>> phoneCodeFutureResult;

  final PhoneVerificationData verificationData;

  final ValueChanged<PhonePageResult> onChangedPhoneCallback;

  @override
  String get phoneNumber => verificationData.phoneNumber;

  @override
  bool get isPhoneValid => phoneValidator.validate(fullPhone).isSuccess;

  String get fullPhone => verificationData.phoneNumberWithDialCode;

  @override
  String get countryCode => verificationData.countryCode;

  @override
  bool get continueEnabled => isPhoneValid && !isLoading;

  @override
  bool get isLoading => phoneCodeFutureResult.isPending();

  PhoneFormPresentationModel byUpdatingVerificationData(
    PhoneVerificationData Function(PhoneVerificationData) mapper,
  ) =>
      copyWith(
        verificationData: mapper(verificationData),
      );

  PhoneFormPresentationModel copyWith({
    PhoneVerificationData? verificationData,
    PhoneValidator? phoneValidator,
    FutureResult<Either<RequestPhoneCodeFailure, PhoneVerificationData>>? phoneCodeFutureResult,
    ValueChanged<PhonePageResult>? onChangedPhoneCallback,
  }) {
    return PhoneFormPresentationModel._(
      verificationData: verificationData ?? this.verificationData,
      phoneValidator: phoneValidator ?? this.phoneValidator,
      phoneCodeFutureResult: phoneCodeFutureResult ?? this.phoneCodeFutureResult,
      onChangedPhoneCallback: onChangedPhoneCallback ?? this.onChangedPhoneCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CongratsFormViewModel {
  String get phoneNumber;

  bool get continueEnabled;

  String get countryCode;

  bool get isPhoneValid;

  bool get isLoading;
}
