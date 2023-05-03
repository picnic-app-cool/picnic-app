import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/sign_in_captcha_params.dart';

class GqlSignInCaptchaParams {
  const GqlSignInCaptchaParams({
    required this.recaptchaSiteKey,
  });

  factory GqlSignInCaptchaParams.fromJson(Map<String, dynamic> json) => GqlSignInCaptchaParams(
        recaptchaSiteKey: asT<String>(asT(json, 'getSignInCaptchaParams'), 'recaptchaSiteKey'),
      );

  final String recaptchaSiteKey;

  SignInCaptchaParams toDomain() => SignInCaptchaParams(
        recaptchaSiteKey: recaptchaSiteKey,
      );
}
