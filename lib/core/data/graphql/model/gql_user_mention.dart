import 'package:picnic_app/core/data/graphql/model/gql_contact_phone_number.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/model/user_type.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlUserMention {
  GqlUserMention({
    required this.id,
    required this.avatar,
    required this.name,
    required this.contactPhoneNumber,
    required this.userType,
    required this.followersCount,
  });

  factory GqlUserMention.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlUserMention(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
      avatar: asT<String>(json, 'avatar'),
      contactPhoneNumber: GqlContactPhoneNumber.fromJson(
        asT<Map<String, dynamic>>(json, 'phoneNumber'),
      ),
      userType: asT<String>(json, 'userType'),
      followersCount: asT<int>(json, 'followersCount'),
    );
  }

  final String id;
  final String avatar;
  final String name;
  final GqlContactPhoneNumber contactPhoneNumber;
  final String userType;
  final int followersCount;

  UserMention toDomain() => UserMention(
        id: Id(id),
        avatar: avatar,
        name: normalizeString(name),
        contactPhoneNumber: contactPhoneNumber.toDomain(),
        userType: UserType.fromString(userType),
        followersCount: followersCount,
      );
}
