import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';

class OnboardingFormData extends Equatable {
  const OnboardingFormData({
    required this.age,
    required this.phoneVerificationData,
    required this.profilePhotoPath,
    required this.username,
    required this.country,
    required this.language,
    required this.circles,
    required this.notificationsStatus,
    required this.authResult,
    required this.usernameVerificationData,
  });

  const OnboardingFormData.empty()
      : age = '',
        phoneVerificationData = const PhoneVerificationData.empty(),
        usernameVerificationData = const UsernameVerificationData.empty(),
        username = '',
        profilePhotoPath = '',
        country = '',
        language = const Language.empty(),
        notificationsStatus = RuntimePermissionStatus.denied,
        authResult = const AuthResult.empty(),
        circles = const [];

  final String age;
  final PhoneVerificationData phoneVerificationData;
  final UsernameVerificationData usernameVerificationData;
  final String username;
  final String country;
  final Language language;
  final String profilePhotoPath;
  final List<BasicCircle> circles;
  final RuntimePermissionStatus notificationsStatus;
  final AuthResult authResult;

  @override
  List<Object?> get props => [
        age,
        phoneVerificationData,
        username,
        country,
        profilePhotoPath,
        language,
        circles,
        notificationsStatus,
        authResult,
        usernameVerificationData,
      ];

  OnboardingFormData copyWith({
    String? age,
    PhoneVerificationData? phoneVerificationData,
    String? username,
    String? country,
    Language? language,
    String? profilePhotoPath,
    List<BasicCircle>? circles,
    RuntimePermissionStatus? notificationsStatus,
    AuthResult? authResult,
    UsernameVerificationData? usernameVerificationData,
  }) {
    return OnboardingFormData(
      age: age ?? this.age,
      phoneVerificationData: phoneVerificationData ?? this.phoneVerificationData,
      username: username ?? this.username,
      country: country ?? this.country,
      language: language ?? this.language,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      circles: circles ?? this.circles,
      notificationsStatus: notificationsStatus ?? this.notificationsStatus,
      authResult: authResult ?? this.authResult,
      usernameVerificationData: usernameVerificationData ?? this.usernameVerificationData,
    );
  }
}
