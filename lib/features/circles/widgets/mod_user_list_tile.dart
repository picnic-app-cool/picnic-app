import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ModUserListTile extends StatelessWidget {
  const ModUserListTile({
    Key? key,
    required this.user,
    this.trailing,
  }) : super(key: key);

  final MinimalPublicProfile user;
  final Text? trailing;

  static const _avatarSize = 45.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: PicnicListItem(
        title: user.username,
        titleStyle: styles.title10,
        leading: PicnicAvatar(
          size: _avatarSize,
          boxFit: PicnicAvatarChildBoxFit.cover,
          isVerified: user.isVerified,
          imageSource: PicnicImageSource.url(
            ImageUrl(user.profileImageUrl.url),
            fit: BoxFit.cover,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
