import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/sign_in_method.dart';

class SignInWithUsernamePayload extends Equatable {
  const SignInWithUsernamePayload({
    required this.signInMethod,
    required this.maskedIdentifier,
    required this.sessionInfo,
  });

  const SignInWithUsernamePayload.empty()
      : signInMethod = SignInMethod.unknown,
        maskedIdentifier = '',
        sessionInfo = '';

  final SignInMethod signInMethod;
  final String maskedIdentifier;
  final String sessionInfo;

  @override
  List<Object?> get props => [
        signInMethod,
        maskedIdentifier,
        sessionInfo,
      ];

  SignInWithUsernamePayload copyWith({
    SignInMethod? signInMethod,
    String? maskedIdentifier,
    String? sessionInfo,
  }) {
    return SignInWithUsernamePayload(
      signInMethod: signInMethod ?? this.signInMethod,
      maskedIdentifier: maskedIdentifier ?? this.maskedIdentifier,
      sessionInfo: sessionInfo ?? this.sessionInfo,
    );
  }
}
