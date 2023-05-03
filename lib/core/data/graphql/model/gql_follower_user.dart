import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';

class GqlFollowerUser {
  const GqlFollowerUser({
    required this.user,
    required this.followedBy,
    required this.following,
  });

  factory GqlFollowerUser.fromJson(
    Map<String, dynamic> nodeJson,
    Map<String, dynamic> relationsJson,
  ) {
    return GqlFollowerUser(
      user: GqlUser.fromJson(nodeJson),
      followedBy: asT<bool>(relationsJson, 'followedBy'),
      following: asT<bool>(relationsJson, 'following'),
    );
  }

  final GqlUser user;
  final bool followedBy;
  final bool following;

  PublicProfile toDomain() => PublicProfile(
        user: user.toDomain(),
        isBlocked: false,
        iFollow: following,
        followsMe: followedBy,
      );
}
