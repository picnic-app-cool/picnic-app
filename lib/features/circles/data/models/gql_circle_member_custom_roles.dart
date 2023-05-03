import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/circles/data/graphql/model/gql_circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';

class GqlCircleMemberCustomRoles {
  const GqlCircleMemberCustomRoles({
    required this.roles,
    required this.mainRoleId,
    required this.unassigned,
  });

  //ignore: long-method
  factory GqlCircleMemberCustomRoles.fromJson(Map<String, dynamic>? json) {
    List<GqlCircleCustomRole>? rolesList;
    List<GqlCircleCustomRole>? unassignedList;

    if (json != null && json['roles'] != null) {
      rolesList = (json['roles'] as List).map((e) => GqlCircleCustomRole.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (json != null && json['unassigned'] != null) {
      unassignedList =
          (json['unassigned'] as List).map((e) => GqlCircleCustomRole.fromJson(e as Map<String, dynamic>)).toList();
    }

    return GqlCircleMemberCustomRoles(
      roles: rolesList,
      mainRoleId: asT<String>(json, 'mainRoleId'),
      unassigned: unassignedList,
    );
  }

  final List<GqlCircleCustomRole>? roles;
  final String mainRoleId;
  final List<GqlCircleCustomRole>? unassigned;

  CircleMemberCustomRoles toDomain() => CircleMemberCustomRoles(
        roles: roles?.map((e) => e.toDomain()).toList() ?? [],
        mainRoleId: mainRoleId,
        unassigned: unassigned?.map((e) => e.toDomain()).toList() ?? [],
      );
}
