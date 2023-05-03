import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });

  const AuthToken.empty()
      : //
        accessToken = '', //
        refreshToken = '' //
  ;

  final String accessToken;
  final String refreshToken;

  @override
  List<Object> get props => [
        accessToken,
        refreshToken,
      ];

  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
