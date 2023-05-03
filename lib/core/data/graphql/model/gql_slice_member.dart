import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';

class GqlSliceMember {
  const GqlSliceMember({
    required this.role,
    required this.user,
    required this.sliceId,
    required this.bannedAt,
    required this.joinedAt,
    required this.userId,
  });

  factory GqlSliceMember.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlSliceMember(
      user: GqlPublicProfile.fromJson(asT<Map<String, dynamic>>(json, 'user')),
      role: asT(json, 'role'),
      sliceId: asT(json, 'sliceId'),
      bannedAt: asT(json, 'bannedAt'),
      joinedAt: asT(json, 'joinedAt'),
      userId: asT(json, 'userId'),
    );
  }

  final String sliceId;
  final String userId;
  final GqlPublicProfile user;
  final String role;
  final String joinedAt;
  final String bannedAt;

  SliceMember toDomain(UserStore userStore) => SliceMember(
        user: user.toDomain(userStore),
        role: SliceRole.fromString(role),
        sliceId: Id(sliceId),
        bannedAtString: bannedAt,
        userId: Id(userId),
        joinedAtString: joinedAt,
      );
}
