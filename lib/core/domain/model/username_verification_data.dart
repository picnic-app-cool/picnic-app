import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';

/// Holds data for username verification process
class UsernameVerificationData extends Equatable {
  const UsernameVerificationData({
    required this.username,
    required this.signInWithUsernamePayload,
    required this.code,
  });

  const UsernameVerificationData.empty()
      : username = '',
        signInWithUsernamePayload = const SignInWithUsernamePayload.empty(),
        code = '';

  final String username;
  final SignInWithUsernamePayload signInWithUsernamePayload;
  final String code;

  @override
  List<Object?> get props => [
        username,
        signInWithUsernamePayload,
        code,
      ];

  UsernameVerificationData copyWith({
    String? username,
    SignInWithUsernamePayload? signInWithUsernamePayload,
    String? code,
  }) {
    return UsernameVerificationData(
      username: username ?? this.username,
      signInWithUsernamePayload: signInWithUsernamePayload ?? this.signInWithUsernamePayload,
      code: code ?? this.code,
    );
  }
}
