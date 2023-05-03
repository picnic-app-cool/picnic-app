import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/sign_in_captcha_params.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_captcha_params_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/sign_in_with_username_failure.dart';

abstract class AuthRepository {
  Future<Either<RequestPhoneCodeFailure, PhoneVerificationData>> requestPhoneCode({
    required PhoneVerificationData verificationData,
  });

  Future<Either<LogInFailure, AuthResult>> logIn({
    required LogInCredentials credentials,
  });

  Future<Either<RegisterFailure, AuthResult>> register({
    required OnboardingFormData formData,
  });

  Future<Either<GetCaptchaParamsFailure, SignInCaptchaParams>> getCaptchaParams();

  Future<Either<SignInWithUsernameFailure, SignInWithUsernamePayload>> signInWithUsername({
    required String username,
    required String recaptchaToken,
  });
}
