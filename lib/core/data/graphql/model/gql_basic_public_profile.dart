import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlBasicPublicProfile {
  GqlBasicPublicProfile({
    required this.id,
    required this.username,
    required this.iFollow,
    required this.isVerified,
    required this.profileImage,
  });

  factory GqlBasicPublicProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlBasicPublicProfile(
      id: asT<String>(json, 'id'),
      username: asT<String>(json, 'username'),
      isVerified: asT<bool>(json, 'isVerified'),
      profileImage: asT<String>(json, 'profileImage'),
      iFollow: asT<bool>(json, 'isFollowing'),
    );
  }

  final String id;
  final String username;
  final bool isVerified;
  final bool iFollow;
  final String profileImage;

  BasicPublicProfile toDomain(UserStore userStore) => BasicPublicProfile(
        id: Id(id),
        username: normalizeString(username),
        iFollow: userStore.isMe(Id(id)) || iFollow,
        isVerified: isVerified,
        profileImageUrl: ImageUrl(profileImage),
      );
}
