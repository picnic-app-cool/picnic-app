import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/recaptcha_verification_failure.dart';

abstract class RecaptchaRepository {
  Future<Either<RecaptchaVerificationFailure, String>> getRecaptchaVerificationTokenViaWebview(String siteKey);
}
