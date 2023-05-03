import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';
import 'package:picnic_app/core/domain/use_cases/recaptcha_verification_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_code_for_username_login_failure.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_captcha_params_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/sign_in_with_username_use_case.dart';

class RequestCodeForUsernameLoginUseCase {
  const RequestCodeForUsernameLoginUseCase(
    this._getCaptchaParamsUseCase,
    this._recaptchaVerificationUseCase,
    this._signInWithUsernameUseCase,
  );

  final GetCaptchaParamsUseCase _getCaptchaParamsUseCase;
  final RecaptchaVerificationUseCase _recaptchaVerificationUseCase;
  final SignInWithUsernameUseCase _signInWithUsernameUseCase;

  Future<Either<RequestCodeForUsernameLoginFailure, UsernameVerificationData>> execute({
    required String username,
  }) =>
      _getCaptchaParamsUseCase
          .execute()
          .mapFailure(RequestCodeForUsernameLoginFailure.unknown)
          .flatMap(
            (a) => _recaptchaVerificationUseCase
                .execute(siteKey: a.recaptchaSiteKey)
                .mapFailure(RequestCodeForUsernameLoginFailure.unknown),
          )
          .flatMap(
            (a) => _signInWithUsernameUseCase
                .execute(username: username, recaptchaToken: a)
                .mapFailure(RequestCodeForUsernameLoginFailure.unknown),
          )
          .mapSuccess(
            (response) => UsernameVerificationData(
              username: username,
              signInWithUsernamePayload: response,
              code: '',
            ),
          );
}
