import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

class UsernameLogInCredentials extends Equatable implements LogInCredentials {
  const UsernameLogInCredentials(
    this.verificationData,
  );

  const UsernameLogInCredentials.empty() : verificationData = const UsernameVerificationData.empty();

  final UsernameVerificationData verificationData;

  @override
  LogInType get type => LogInType.username;

  @override
  List<Object?> get props => [
        verificationData,
      ];

  UsernameLogInCredentials copyWith({
    UsernameVerificationData? verificationData,
  }) {
    return UsernameLogInCredentials(
      verificationData ?? this.verificationData,
    );
  }
}
