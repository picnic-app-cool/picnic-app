import 'package:equatable/equatable.dart';

class SignInCaptchaParams extends Equatable {
  const SignInCaptchaParams({
    required this.recaptchaSiteKey,
  });

  const SignInCaptchaParams.empty() : recaptchaSiteKey = '';

  final String recaptchaSiteKey;

  @override
  List<Object?> get props => [
        recaptchaSiteKey,
      ];

  SignInCaptchaParams copyWith({
    String? recaptchaSiteKey,
  }) {
    return SignInCaptchaParams(
      recaptchaSiteKey: recaptchaSiteKey ?? this.recaptchaSiteKey,
    );
  }
}
