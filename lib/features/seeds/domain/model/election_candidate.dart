import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';

class ElectionCandidate extends Equatable {
  const ElectionCandidate({
    required this.circleId,
    required this.publicProfile,
    required this.role,
    required this.votesCount,
    required this.votesPercent,
    required this.isBanned,
    required this.iVoted,
    required this.bannedAtString,
    required this.bannedTime,
    required this.circleMemberCustomRoles,
  });

  const ElectionCandidate.empty()
      : circleId = const Id.empty(),
        publicProfile = const PublicProfile.empty(),
        role = CircleRole.member,
        votesCount = 0,
        votesPercent = 0.0,
        isBanned = false,
        iVoted = false,
        bannedAtString = '',
        bannedTime = 0,
        circleMemberCustomRoles = const CircleMemberCustomRoles.empty();

  final Id circleId;
  final PublicProfile publicProfile;
  final CircleRole role;
  final int votesCount;
  final double votesPercent;
  final bool isBanned;
  final bool iVoted;
  final CircleMemberCustomRoles circleMemberCustomRoles;

  final String bannedAtString;
  final int bannedTime;
  static const total = 100;

  DateTime? get bannedAt => DateTime.tryParse(bannedAtString);

  String get username => publicProfile.username;

  double get percentage => votesPercent / total;

  ImageUrl get profilePictureUrl => publicProfile.profileImageUrl;

  Id get userId => publicProfile.id;

  CircleCustomRole get mainRole {
    return circleMemberCustomRoles.roles
            .firstWhereOrNull((role) => role.id.value == circleMemberCustomRoles.mainRoleId) ??
        const CircleCustomRole.empty();
  }

  @override
  List<Object?> get props => [
        circleId,
        publicProfile,
        role,
        votesCount,
        votesPercent,
        iVoted,
        isBanned,
        bannedAtString,
        bannedTime,
        circleMemberCustomRoles,
      ];

  ElectionCandidate copyWith({
    Id? circleId,
    PublicProfile? publicProfile,
    CircleRole? role,
    int? votesCount,
    double? votesPercent,
    bool? isBanned,
    bool? iVoted,
    String? bannedAtString,
    int? bannedTime,
    CircleMemberCustomRoles? circleMemberCustomRoles,
  }) {
    return ElectionCandidate(
      circleId: circleId ?? this.circleId,
      publicProfile: publicProfile ?? this.publicProfile,
      role: role ?? this.role,
      votesCount: votesCount ?? this.votesCount,
      votesPercent: votesPercent ?? this.votesPercent,
      isBanned: isBanned ?? this.isBanned,
      iVoted: iVoted ?? this.iVoted,
      bannedAtString: bannedAtString ?? this.bannedAtString,
      bannedTime: bannedTime ?? this.bannedTime,
      circleMemberCustomRoles: circleMemberCustomRoles ?? this.circleMemberCustomRoles,
    );
  }
}
