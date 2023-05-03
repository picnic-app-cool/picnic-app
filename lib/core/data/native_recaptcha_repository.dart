import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:picnic_app/core/domain/model/recaptcha_verification_failure.dart';
import 'package:picnic_app/core/domain/repositories/recaptcha_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:recaptcha_verification/recaptcha_verification.dart';

class NativeRecaptchaRepository implements RecaptchaRepository {
  NativeRecaptchaRepository(this._recaptchaVerificationPlugin);

  final RecaptchaVerification _recaptchaVerificationPlugin;

  @override
  Future<Either<RecaptchaVerificationFailure, String>> getRecaptchaVerificationTokenViaWebview(
    String siteKey,
  ) async {
    try {
      final verificationToken = await _recaptchaVerificationPlugin.repcaptchaVerification(
        RecaptchaArgs.webview(siteKey: siteKey),
      );
      return success(verificationToken);
    } on PlatformException {
      return failure(const RecaptchaVerificationFailure.unknown());
    }
  }
}
