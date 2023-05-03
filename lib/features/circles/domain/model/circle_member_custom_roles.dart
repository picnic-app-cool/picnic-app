import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';

class CircleMemberCustomRoles extends Equatable {
  const CircleMemberCustomRoles({
    required this.roles,
    required this.mainRoleId,
    required this.unassigned,
  });

  const CircleMemberCustomRoles.empty()
      : roles = const [],
        mainRoleId = '',
        unassigned = const [];

  final List<CircleCustomRole> roles;
  final String mainRoleId;
  final List<CircleCustomRole> unassigned;

  @override
  List<Object?> get props => [
        roles,
        mainRoleId,
        unassigned,
      ];

  CircleMemberCustomRoles copyWith({
    List<CircleCustomRole>? roles,
    String? mainRoleId,
    List<CircleCustomRole>? unassigned,
  }) {
    return CircleMemberCustomRoles(
      roles: roles ?? this.roles,
      mainRoleId: mainRoleId ?? this.mainRoleId,
      unassigned: unassigned ?? this.unassigned,
    );
  }
}
