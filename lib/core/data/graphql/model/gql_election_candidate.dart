import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/data/models/gql_circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';

class GqlElectionCandidate {
  const GqlElectionCandidate({
    required this.role,
    required this.isBanned,
    required this.user,
    required this.circleId,
    required this.votesCount,
    required this.votesPercent,
    required this.bannedAt,
    required this.bannedTime,
    required this.iVoted,
    required this.circleMemberCustomRoles,
  });

  factory GqlElectionCandidate.fromJson(
    Map<String, dynamic> json,
  ) {
    GqlCircleMemberCustomRoles? gqlCircleMemberCustomRoles;

    if (json['roles'] != null) {
      gqlCircleMemberCustomRoles = GqlCircleMemberCustomRoles.fromJson((json['roles'] as Map).cast());
    }

    return GqlElectionCandidate(
      user: GqlPublicProfile.fromJson(asT<Map<String, dynamic>>(json, 'user')),
      isBanned: asT<bool>(json, 'isBanned'),
      role: asT<String>(json, 'role'),
      circleId: asT<String>(json, 'circleId'),
      votesCount: asT<int>(json, 'votesCount'),
      votesPercent: asT<double>(json, 'votesPercent'),
      bannedAt: asT<String>(json, 'bannedAt'),
      bannedTime: asT<int>(json, 'bannedTime'),
      iVoted: asT<bool>(json, 'iVoted'),
      circleMemberCustomRoles: gqlCircleMemberCustomRoles,
    );
  }

  final String circleId;
  final GqlPublicProfile user;
  final bool isBanned;
  final String role;
  final int votesCount;
  final double votesPercent;
  final String bannedAt;
  final int bannedTime;
  final bool iVoted;
  final GqlCircleMemberCustomRoles? circleMemberCustomRoles;

  ElectionCandidate toDomain(UserStore userStore) => ElectionCandidate(
        publicProfile: user.toDomain(userStore),
        isBanned: isBanned,
        role: CircleRole.fromString(role),
        circleId: Id(circleId),
        votesCount: votesCount,
        votesPercent: votesPercent,
        bannedAtString: bannedAt,
        bannedTime: bannedTime,
        iVoted: iVoted,
        circleMemberCustomRoles: circleMemberCustomRoles?.toDomain() ?? const CircleMemberCustomRoles.empty(),
      );
}
