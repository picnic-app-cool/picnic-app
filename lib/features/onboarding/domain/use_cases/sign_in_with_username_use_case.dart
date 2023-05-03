import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/features/onboarding/domain/model/sign_in_with_username_failure.dart';

class SignInWithUsernameUseCase {
  const SignInWithUsernameUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Either<SignInWithUsernameFailure, SignInWithUsernamePayload>> execute({
    required String username,
    required String recaptchaToken,
  }) =>
      _authRepository.signInWithUsername(username: username, recaptchaToken: recaptchaToken);
}
