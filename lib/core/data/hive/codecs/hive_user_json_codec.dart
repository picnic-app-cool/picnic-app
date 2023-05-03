import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_meta.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/json_codec.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class HiveUserJsonCodec extends JsonCodec<PrivateProfile> {
  final String _id = 'id';
  final String _username = 'username';
  final String _bio = "bio";
  final String _profileImageUrl = 'profileImageUrl';
  final String _createdAt = 'createdAt';
  final String _shareLink = 'shareLink';
  final String _isVerified = 'isVerified';
  final String _email = 'email';
  final String _language = 'language';
  final String _melonsAmount = 'melonsAmount';
  final String _seedsAmount = 'seedsAmount';
  final String _age = 'age';
  final String _fullName = 'fullName';

  final String _meta = 'meta';

  @override
  PrivateProfile fromJson(Map<String, dynamic> json) {
    return PrivateProfile(
      user: User(
        id: Id(asT<String>(json, _id)),
        username: asT<String>(json, _username),
        fullName: asT<String>(json, _fullName),
        bio: asT<String>(json, _bio),
        profileImageUrl: ImageUrl(asT<String>(json, _profileImageUrl)),
        createdAt: asT<String>(json, _createdAt),
        shareLink: asT<String>(json, _shareLink),
        isVerified: asT<bool>(json, _isVerified),
      ),
      email: asT<String>(json, _email),
      languages: asListPrimitive<String>(json, _language),
      melonsAmount: asT<int>(json, _melonsAmount),
      seedsAmount: asT<int>(json, _seedsAmount),
      age: asT<int>(json, _age),
      meta: const ProfileMeta.empty(),
    );
  }

  @override
  Map<String, dynamic> toJson(PrivateProfile obj) => {
        _id: obj.user.id.value,
        _username: obj.user.username,
        _bio: obj.user.bio,
        _profileImageUrl: obj.user.profileImageUrl.url,
        _createdAt: obj.user.createdAt,
        _isVerified: obj.user.isVerified,
        _email: obj.email,
        _language: obj.languages,
        _melonsAmount: obj.melonsAmount,
        _seedsAmount: obj.seedsAmount,
        _age: obj.age,
        _meta: obj.meta,
      };
}
