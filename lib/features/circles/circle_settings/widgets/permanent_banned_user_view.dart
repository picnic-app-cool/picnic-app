import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/unban_button.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PermanentBannedUserView extends StatelessWidget {
  const PermanentBannedUserView({
    Key? key,
    required this.user,
    required this.onTapUnban,
    required this.onBannedUserTap,
  }) : super(key: key);

  final BannedUser user;
  final Function(BannedUser) onTapUnban;
  final Function(BannedUser) onBannedUserTap;

  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return PicnicListItem(
      height: null,
      title: user.userName,
      titleStyle: PicnicTheme.of(context).styles.title10,
      leading: PicnicAvatar(
        size: _avatarSize,
        boxFit: PicnicAvatarChildBoxFit.cover,
        borderColor: Colors.white,
        imageSource: PicnicImageSource.url(
          ImageUrl(user.userAvatar),
          fit: BoxFit.cover,
        ),
        placeholder: () => DefaultAvatar.user(),
        onTap: () => onBannedUserTap(user),
      ),
      trailing: UnbanButton(
        onTap: () => onTapUnban(user),
      ),
    );
  }
}
