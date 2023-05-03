import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

class AppleLogInCredentials extends Equatable implements LogInCredentials {
  const AppleLogInCredentials();

  const AppleLogInCredentials.empty() : this();

  @override
  LogInType get type => LogInType.apple;

  @override
  List<Object?> get props => [
        type,
      ];
}
