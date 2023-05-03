import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';

class RequestPhoneCodeUseCase {
  const RequestPhoneCodeUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  Future<Either<RequestPhoneCodeFailure, PhoneVerificationData>> execute({
    required PhoneVerificationData verificationData,
  }) =>
      _authRepository.requestPhoneCode(verificationData: verificationData);
}
