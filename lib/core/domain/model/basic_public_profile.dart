import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// minimal info about the public profile of a user, ideal for lists
class BasicPublicProfile extends Equatable implements MinimalPublicProfile {
  const BasicPublicProfile({
    required this.id,
    required this.username,
    required this.iFollow,
    required this.isVerified,
    required this.profileImageUrl,
  });

  const BasicPublicProfile.empty()
      : id = const Id(''),
        username = '',
        iFollow = false,
        isVerified = false,
        profileImageUrl = const ImageUrl.empty();

  BasicPublicProfile.fromPublicProfile(PublicProfile profile)
      : id = profile.id,
        username = profile.username,
        iFollow = profile.iFollow,
        isVerified = profile.isVerified,
        profileImageUrl = profile.profileImageUrl;

  @override
  final bool iFollow;
  @override
  final bool isVerified;
  @override
  final String username;
  @override
  final ImageUrl profileImageUrl;
  @override
  final Id id;

  @override
  List<Object> get props => [
        id,
        username,
        iFollow,
        profileImageUrl,
        isVerified,
      ];

  BasicPublicProfile copyWith({
    bool? iFollow,
    bool? isVerified,
    String? username,
    ImageUrl? profileImageUrl,
    Id? id,
  }) {
    return BasicPublicProfile(
      iFollow: iFollow ?? this.iFollow,
      isVerified: isVerified ?? this.isVerified,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      id: id ?? this.id,
    );
  }
}
