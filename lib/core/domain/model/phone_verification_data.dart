import 'package:equatable/equatable.dart';

/// Holds data returned from phone verification request
class PhoneVerificationData extends Equatable {
  const PhoneVerificationData({
    required this.verificationId,
    required this.smsCode,
    required this.phoneNumber,
    required this.dialCode,
    required this.countryCode,
  });

  const PhoneVerificationData.empty()
      : verificationId = '',
        smsCode = '',
        phoneNumber = '',
        dialCode = '+1',
        countryCode = 'US';

  /// verification id returned by backend, it needs to be sent along with sms code to authenticate user
  final String verificationId;

  /// code sent in sms
  final String smsCode;

  /// phone number portion, without dial code
  final String phoneNumber;

  /// country dial code, i.e: +1 for US
  final String dialCode;

  final String countryCode;

  @override
  List<Object> get props => [
        verificationId,
        smsCode,
        phoneNumber,
        dialCode,
        countryCode,
      ];

  String get phoneNumberWithDialCode => "$dialCode$phoneNumber";

  PhoneVerificationData copyWith({
    String? verificationId,
    String? smsCode,
    String? phoneNumber,
    String? dialCode,
    String? countryCode,
  }) {
    return PhoneVerificationData(
      verificationId: verificationId ?? this.verificationId,
      smsCode: smsCode ?? this.smsCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dialCode: dialCode ?? this.dialCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
