import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/profile/followers/widgets/follow_user_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MemberListItem extends StatelessWidget {
  const MemberListItem({
    required this.member,
    required this.onTapToggleFollow,
    required this.onTapViewUserProfile,
    required this.privateProfile,
    this.isLoadingOnToggle = false,
    this.hasPermissionToManageUsers = false,
    this.isDirectorsList = false,
    this.onTapEditRole,
    super.key,
  });

  final ValueChanged<CircleMember> onTapToggleFollow;
  final ValueChanged<CircleMember> onTapViewUserProfile;
  final Function(CircleMember)? onTapEditRole;
  final bool isLoadingOnToggle;
  final bool hasPermissionToManageUsers;
  final bool isDirectorsList;
  final CircleMember member;

  final PrivateProfile privateProfile;

  static const _avatarSize = 40.0;
  static const _badeRatio = 0.4;

  static const _followerItemHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final badge = SizedBox(
      width: _avatarSize,
      height: _avatarSize,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Assets.images.verificationBadgePink.image(width: _avatarSize * _badeRatio),
      ),
    );

    final picnicAvatar = PicnicAvatar(
      backgroundColor: theme.colors.lightBlue.shade100,
      size: _avatarSize,
      boxFit: PicnicAvatarChildBoxFit.cover,
      imageSource: PicnicImageSource.url(
        member.user.profileImageUrl,
        fit: BoxFit.cover,
      ),
      placeholder: () => DefaultAvatar.user(),
    );
    final avatar = member.user.isVerified
        ? Stack(
            children: [
              picnicAvatar,
              badge,
            ],
          )
        : picnicAvatar;
    final followButton = member.user.id == privateProfile.id
        ? null
        : FollowUserButton(
            onTapToggleFollow: isLoadingOnToggle ? null : () => onTapToggleFollow(member),
            isFollowing: member.user.iFollow,
          );
    final trailing = isDirectorsList
        ? Text(
            member.type.valueToDisplay,
            style: theme.styles.title30.copyWith(color: PicnicColors.bluishCyan),
          )
        : hasPermissionToManageUsers
            ? GestureDetector(
                onTap: onTapEditRole != null ? () => onTapEditRole!(member) : null,
                child: Image.asset(Assets.images.edit.path, color: theme.colors.green),
              )
            : followButton;
    final usernameColor = member.formattedMainRoleColor;
    return PicnicListItem(
      onTap: () => onTapViewUserProfile(member),
      height: _followerItemHeight,
      leading: avatar,
      title: member.user.username,
      titleStyle: theme.styles.title10.copyWith(color: usernameColor.color),
      trailing: trailing,
    );
  }
}
