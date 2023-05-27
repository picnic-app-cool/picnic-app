import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/members/widgets/members_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class FullMembersList extends StatelessWidget {
  const FullMembersList({
    required this.emptyItems,
    required this.hasMore,
    required this.loadMore,
    required this.onTapViewUserProfile,
    required this.onTapToggleFollow,
    required this.onTapAddRole,
    required this.onTapInviteUsers,
    required this.hasPermissionToManageRoles,
    required this.isLoadingToggleFollow,
    required this.directors,
    required this.members,
    required this.privateProfile,
    required this.hasPermissionToManageUsers,
    this.onTapEditRole,
    super.key,
  });

  final bool emptyItems;
  final bool hasMore;
  final Future<void> Function() loadMore;
  final ValueChanged<CircleMember> onTapViewUserProfile;
  final ValueChanged<CircleMember> onTapToggleFollow;
  final VoidCallback onTapAddRole;
  final VoidCallback onTapInviteUsers;
  final bool hasPermissionToManageUsers;
  final bool hasPermissionToManageRoles;
  final bool isLoadingToggleFollow;
  final PaginatedList<CircleMember> directors;
  final PaginatedList<CircleMember> members;
  final PrivateProfile privateProfile;
  final Function(CircleMember)? onTapEditRole;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final title30 = theme.styles.subtitle40;
    final blueColor = theme.styles.subtitle30.copyWith(color: theme.colors.blue);

    return LoadMoreScrollNotification(
      emptyItems: emptyItems,
      hasMore: hasMore,
      loadMore: loadMore,
      builder: (context) {
        return CustomScrollView(
          slivers: [
            if (directors.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.director,
                        style: title30,
                      ),
                      if (hasPermissionToManageRoles)
                        PicnicTextButton(
                          label: appLocalizations.addRoleLabel,
                          onTap: () => onTapAddRole(),
                          labelStyle: blueColor,
                          padding: EdgeInsets.zero,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                    ],
                  ),
                ),
              ),
            MembersList(
              onTapViewUserProfile: onTapViewUserProfile,
              members: directors,
              onTapToggleFollow: onTapToggleFollow,
              privateProfile: privateProfile,
              loadMoreMembers: loadMore,
              isLoadingOnToggle: isLoadingToggleFollow,
              isDirectorsList: true,
            ),
            if (members.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.users,
                        style: title30,
                      ),
                      if (hasPermissionToManageUsers)
                        PicnicTextButton(
                          label: appLocalizations.inviteAction,
                          onTap: () => onTapInviteUsers(),
                          labelStyle: blueColor,
                          padding: EdgeInsets.zero,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                    ],
                  ),
                ),
              ),
            MembersList(
              onTapViewUserProfile: onTapViewUserProfile,
              members: members,
              onTapToggleFollow: onTapToggleFollow,
              privateProfile: privateProfile,
              loadMoreMembers: loadMore,
              isLoadingOnToggle: isLoadingToggleFollow,
              hasPermissionToManageUsers: hasPermissionToManageUsers,
              onTapEditRole: onTapEditRole,
            ),
          ],
        );
      },
    );
  }
}
