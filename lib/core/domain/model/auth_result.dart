import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class AuthResult extends Equatable {
  const AuthResult({
    required this.userId,
    required this.authToken,
    required this.privateProfile,
  });

  const AuthResult.empty()
      : userId = const Id.none(),
        authToken = const AuthToken.empty(),
        privateProfile = const PrivateProfile.empty();

  final Id userId;
  final AuthToken authToken;
  final PrivateProfile privateProfile;

  bool get passedOnboarding => authToken.accessToken.isNotEmpty;

  bool get authenticated => !userId.isNone;

  @override
  List<Object?> get props => [
        userId,
        authToken,
        privateProfile,
      ];

  AuthResult copyWith({
    Id? userId,
    AuthToken? authToken,
    PrivateProfile? privateProfile,
  }) {
    return AuthResult(
      userId: userId ?? this.userId,
      authToken: authToken ?? this.authToken,
      privateProfile: privateProfile ?? this.privateProfile,
    );
  }
}
