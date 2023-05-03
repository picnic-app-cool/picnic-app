import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/members/widgets/member_list_item.dart';

class MembersList extends StatelessWidget {
  const MembersList({
    required this.members,
    required this.loadMoreMembers,
    required this.onTapToggleFollow,
    required this.onTapViewUserProfile,
    required this.privateProfile,
    this.isLoadingOnToggle = false,
    this.hasPermissionToManageUsers = false,
    this.isDirectorsList = false,
    this.onTapEditRole,
    super.key,
  });

  final PaginatedList<CircleMember> members;

  final Future<void> Function() loadMoreMembers;
  final ValueChanged<CircleMember> onTapToggleFollow;
  final ValueChanged<CircleMember> onTapViewUserProfile;
  final Function(CircleMember)? onTapEditRole;
  final PrivateProfile privateProfile;
  final bool isLoadingOnToggle;
  final bool hasPermissionToManageUsers;
  final bool isDirectorsList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: members.length,
        (context, index) {
          final member = members[index];
          return MemberListItem(
            onTapToggleFollow: onTapToggleFollow,
            onTapViewUserProfile: onTapViewUserProfile,
            privateProfile: privateProfile,
            member: member,
            hasPermissionToManageUsers: hasPermissionToManageUsers,
            isDirectorsList: isDirectorsList,
            onTapEditRole: onTapEditRole,
          );
        },
      ),
    );
  }
}
