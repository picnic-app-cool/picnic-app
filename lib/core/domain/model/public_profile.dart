import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class PublicProfile extends Equatable implements MinimalPublicProfile {
  const PublicProfile({
    required this.user,
    required this.isBlocked,
    required this.iFollow,
    required this.followsMe,
    required this.followers,
  });

  const PublicProfile.empty()
      : user = const User.empty(),
        isBlocked = false,
        iFollow = false,
        followsMe = false,
        followers = 0;

  final User user;
  final bool isBlocked;
  @override
  final bool iFollow;
  final bool followsMe;
  final int followers;

  bool get isMutualFollowing => followsMe && iFollow;

  @override
  bool get isVerified => user.isVerified;

  @override
  String get username => user.username;

  @override
  ImageUrl get profileImageUrl => user.profileImageUrl;

  @override
  Id get id => user.id;

  @override
  List<Object> get props => [
        user,
        isBlocked,
        iFollow,
        followsMe,
        followers,
      ];

  PublicProfile copyWith({
    User? user,
    bool? isBlocked,
    bool? iFollow,
    bool? followsMe,
    int? followers,
  }) {
    return PublicProfile(
      user: user ?? this.user,
      isBlocked: isBlocked ?? this.isBlocked,
      iFollow: iFollow ?? this.iFollow,
      followsMe: followsMe ?? this.followsMe,
      followers: followers ?? this.followers,
    );
  }
}
