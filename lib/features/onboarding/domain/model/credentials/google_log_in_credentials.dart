import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

class GoogleLogInCredentials extends Equatable implements LogInCredentials {
  const GoogleLogInCredentials();

  const GoogleLogInCredentials.empty() : this();

  @override
  LogInType get type => LogInType.google;

  @override
  List<Object?> get props => [
        type,
      ];
}
