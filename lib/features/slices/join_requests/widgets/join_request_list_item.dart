import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class JoinRequestListItem extends StatelessWidget {
  const JoinRequestListItem({
    Key? key,
    required this.onTapApprove,
    required this.onTapViewUserProfile,
    this.isApproveLoading = false,
    required this.userProfile,
  }) : super(key: key);

  final Function(PublicProfile) onTapApprove;
  final Function(Id) onTapViewUserProfile;
  final bool isApproveLoading;
  final PublicProfile userProfile;

  static const _avatarSize = 40.0;
  static const _badgeRatio = 0.4;

  static const _joinRequestItemHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final badge = SizedBox(
      width: _avatarSize,
      height: _avatarSize,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Assets.images.achievement.image(width: _avatarSize * _badgeRatio),
      ),
    );

    final picnicAvatar = PicnicAvatar(
      backgroundColor: theme.colors.lightBlue.shade100,
      size: _avatarSize,
      boxFit: PicnicAvatarChildBoxFit.cover,
      imageSource: PicnicImageSource.url(
        userProfile.profileImageUrl,
        fit: BoxFit.cover,
      ),
      placeholder: () => DefaultAvatar.user(),
    );
    final avatar = userProfile.isVerified
        ? Stack(
            children: [
              picnicAvatar,
              badge,
            ],
          )
        : picnicAvatar;
    return PicnicListItem(
      onTap: () => onTapViewUserProfile(userProfile.id),
      height: _joinRequestItemHeight,
      leading: avatar,
      title: userProfile.username,
      titleStyle: theme.styles.subtitle20,
      trailing: PicnicButton(
        title: appLocalizations.approveButtonTitle,
        color: colors.blue,
        titleColor: colors.blackAndWhite.shade100,
        onTap: () => onTapApprove(userProfile),
      ),
    );
  }
}
