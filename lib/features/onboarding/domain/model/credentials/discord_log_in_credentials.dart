import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

class DiscordLogInCredentials extends Equatable implements LogInCredentials {
  const DiscordLogInCredentials(
    this.code,
  );

  const DiscordLogInCredentials.empty() : code = '';

  final String code;

  @override
  LogInType get type => LogInType.apple;

  @override
  List<Object?> get props => [
        type,
        code,
      ];

  DiscordLogInCredentials copyWith({
    String? code,
  }) {
    return DiscordLogInCredentials(
      code ?? this.code,
    );
  }
}
