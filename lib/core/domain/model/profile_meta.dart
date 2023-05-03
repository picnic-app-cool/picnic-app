import 'package:equatable/equatable.dart';

class ProfileMeta extends Equatable {
  const ProfileMeta({
    required this.pendingSteps,
  });

  const ProfileMeta.empty() : pendingSteps = const [];

  final List<ProfileSetupStep> pendingSteps;

  @override
  List<Object?> get props => [
        pendingSteps,
      ];

  ProfileMeta copyWith({
    List<ProfileSetupStep>? pendingSteps,
  }) {
    return ProfileMeta(
      pendingSteps: pendingSteps ?? this.pendingSteps,
    );
  }

  //ignore: domain_json
  Map<String, dynamic> toJson() => {
        'pendingSteps': pendingSteps,
      };
}

enum ProfileSetupStep {
  none(value: 'None'),
  age(value: 'Age'),
  email(value: 'Email'),
  phone(value: 'Phone'),
  circles(value: 'Circles'),
  username(value: 'Username'),
  languages(value: 'Languages'),
  profileImage(value: 'ProfileImage');

  const ProfileSetupStep({required this.value});

  final String value;

  static ProfileSetupStep fromString(String value) => ProfileSetupStep.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ProfileSetupStep.none,
      );

  String toJson() {
    return value;
  }
}
