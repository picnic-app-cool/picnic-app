import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlUser {
  GqlUser({
    required this.id,
    required this.username,
    required this.fullName,
    required this.bio,
    required this.isVerified,
    required this.profileImage,
    required this.createdAt,
    required this.shareLink,
  });

  factory GqlUser.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlUser(
      id: asT<String>(json, 'id'),
      username: asT<String>(json, 'username'),
      fullName: asT<String>(json, 'fullName'),
      bio: asT<String>(json, 'bio'),
      isVerified: asT<bool>(json, 'isVerified'),
      profileImage: asT<String>(json, 'profileImage'),
      createdAt: asT<String>(json, 'createdAt'),
      shareLink: asT<String>(json, 'shareLink'),
    );
  }

  final String id;
  final String username;
  final String fullName;
  final String bio;

  final bool isVerified;
  final String profileImage;
  final String createdAt;
  final String shareLink;

  User toDomain() => User(
        id: Id(id),
        username: normalizeString(username),
        fullName: fullName,
        bio: bio,
        profileImageUrl: ImageUrl(profileImage),
        createdAt: createdAt,
        isVerified: isVerified,
        shareLink: shareLink,
      );
}
