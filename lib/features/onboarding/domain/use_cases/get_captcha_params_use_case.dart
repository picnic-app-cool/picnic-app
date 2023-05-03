import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/sign_in_captcha_params.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_captcha_params_failure.dart';

class GetCaptchaParamsUseCase {
  const GetCaptchaParamsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Either<GetCaptchaParamsFailure, SignInCaptchaParams>> execute() => _authRepository.getCaptchaParams();
}
