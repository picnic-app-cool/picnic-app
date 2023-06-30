import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/country_with_dial_code.dart';

/// Holds data returned from phone verification request
class PhoneVerificationData extends Equatable {
  const PhoneVerificationData({
    required this.verificationId,
    required this.smsCode,
    required this.phoneNumber,
    required this.country,
  });

  const PhoneVerificationData.empty()
      : verificationId = '',
        smsCode = '',
        phoneNumber = '',
        country = const CountryWithDialCode(
          code: '+1',
          name: 'US',
          flag: '🇺🇸',
        );

  /// verification id returned by backend, it needs to be sent along with sms code to authenticate user
  final String verificationId;

  /// code sent in sms
  final String smsCode;

  /// phone number portion, without dial code
  final String phoneNumber;

  /// country with dial code
  final CountryWithDialCode country;

  @override
  List<Object> get props => [
        verificationId,
        smsCode,
        phoneNumber,
        country,
        country,
      ];

  String get phoneNumberWithDialCode => "${country.code}$phoneNumber";

  PhoneVerificationData copyWith({
    String? verificationId,
    String? smsCode,
    String? phoneNumber,
    CountryWithDialCode? country,
  }) {
    return PhoneVerificationData(
      verificationId: verificationId ?? this.verificationId,
      smsCode: smsCode ?? this.smsCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
    );
  }
}
