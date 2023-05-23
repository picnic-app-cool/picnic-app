import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/followers/widgets/follow_user_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FollowerListItem extends StatelessWidget {
  const FollowerListItem({
    Key? key,
    required this.onTapToggleFollow,
    required this.onTapViewUserProfile,
    required this.privateProfile,
    this.isLoadingOnToggle = false,
    required this.follower,
  }) : super(key: key);

  final Function(PublicProfile) onTapToggleFollow;
  final Function(Id) onTapViewUserProfile;
  final bool isLoadingOnToggle;
  final PublicProfile follower;

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
        follower.profileImageUrl,
        fit: BoxFit.cover,
      ),
      placeholder: () => DefaultAvatar.user(),
    );
    final avatar = follower.isVerified
        ? Stack(
            children: [
              picnicAvatar,
              badge,
            ],
          )
        : picnicAvatar;
    return PicnicListItem(
      onTap: () => onTapViewUserProfile(follower.id),
      height: _followerItemHeight,
      leading: avatar,
      title: follower.username,
      titleStyle: theme.styles.title10,
      trailing: follower.id == privateProfile.id
          ? null
          : FollowUserButton(
              onTapToggleFollow: isLoadingOnToggle ? null : () => onTapToggleFollow(follower),
              isFollowing: follower.iFollow,
            ),
    );
  }
}
