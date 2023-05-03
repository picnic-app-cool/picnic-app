import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';

class GqlPublicProfile {
  const GqlPublicProfile({
    required this.user,
    required this.isBlocked,
    required this.iFollow,
    required this.followsMe,
  });

  factory GqlPublicProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlPublicProfile(
      user: GqlUser.fromJson(json),
      isBlocked: asT<bool>(json, 'isBlocked'),
      iFollow: asT<bool>(json, 'isFollowing'),
      followsMe: asT<bool>(json, 'followsMe'),
    );
  }

  final GqlUser user;
  final bool isBlocked;
  final bool iFollow;
  final bool followsMe;

  PublicProfile toDomain(UserStore userStore) {
    final domainUser = user.toDomain();
    return PublicProfile(
      user: domainUser,
      isBlocked: isBlocked,
      iFollow: userStore.isMe(domainUser.id) || iFollow,
      followsMe: followsMe,
    );
  }
}
