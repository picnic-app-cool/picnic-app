import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

class PhoneLogInCredentials extends Equatable implements LogInCredentials {
  const PhoneLogInCredentials(this.verificationData);

  const PhoneLogInCredentials.empty() : verificationData = const PhoneVerificationData.empty();

  final PhoneVerificationData verificationData;

  @override
  LogInType get type => LogInType.phone;

  @override
  List<Object?> get props => [
        type,
        verificationData,
      ];

  PhoneLogInCredentials copyWith({
    PhoneVerificationData? verificationData,
  }) {
    return PhoneLogInCredentials(
      verificationData ?? this.verificationData,
    );
  }
}
