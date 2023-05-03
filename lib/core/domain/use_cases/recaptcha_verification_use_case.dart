import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/recaptcha_verification_failure.dart';
import 'package:picnic_app/core/domain/repositories/recaptcha_repository.dart';

class RecaptchaVerificationUseCase {
  const RecaptchaVerificationUseCase(this._recaptchaRepository);

  final RecaptchaRepository _recaptchaRepository;

  Future<Either<RecaptchaVerificationFailure, String>> execute({
    required String siteKey,
  }) =>
      _recaptchaRepository.getRecaptchaVerificationTokenViaWebview(siteKey);
}
