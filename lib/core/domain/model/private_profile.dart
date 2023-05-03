import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/profile_meta.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class PrivateProfile extends Equatable {
  const PrivateProfile({
    required this.user,
    required this.email,
    required this.languages,
    required this.melonsAmount,
    required this.seedsAmount,
    required this.age,
    required this.meta,
  });

  const PrivateProfile.empty()
      : user = const User.empty(),
        email = '',
        languages = const [],
        melonsAmount = 0,
        meta = const ProfileMeta.empty(),
        seedsAmount = 0,
        age = 0;

  const PrivateProfile.anonymous()
      : user = const User.anonymous(),
        email = '',
        languages = const [],
        meta = const ProfileMeta.empty(),
        melonsAmount = 0,
        seedsAmount = 0,
        age = 0;

  final User user;
  final String email;
  final ProfileMeta meta;

  final List<String> languages;
  final int melonsAmount;
  final int seedsAmount;
  final int age;

  bool get isVerified => user.isVerified;

  String get username => user.username;

  bool get agePending => meta.pendingSteps.contains(ProfileSetupStep.age) || age == 0;

  bool get circlesPending => meta.pendingSteps.contains(ProfileSetupStep.circles);

  String get bio => user.bio;

  ImageUrl get profileImageUrl => user.profileImageUrl;

  Id get id => user.id;

  String get fullName => user.fullName;

  @override
  List<Object> get props => [
        user,
        email,
        languages,
        melonsAmount,
        seedsAmount,
        age,
        meta,
      ];

  PrivateProfile copyWith({
    User? user,
    String? email,
    List<String>? languages,
    int? melonsAmount,
    int? seedsAmount,
    int? age,
    ProfileMeta? meta,
  }) {
    return PrivateProfile(
      user: user ?? this.user,
      email: email ?? this.email,
      languages: languages ?? this.languages,
      melonsAmount: melonsAmount ?? this.melonsAmount,
      seedsAmount: seedsAmount ?? this.seedsAmount,
      age: age ?? this.age,
      meta: meta ?? this.meta,
    );
  }

  bool isSameUser({required Id userId}) => id == userId;
}

extension BasicPublicProfileMapper on PrivateProfile {
  BasicPublicProfile toBasicPublicProfile() => const BasicPublicProfile.empty().copyWith(
        username: user.username,
        id: user.id,
        profileImageUrl: user.profileImageUrl,
      );
}
