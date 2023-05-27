import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SingleChatSettingsHeader extends StatelessWidget {
  const SingleChatSettingsHeader({
    Key? key,
    required this.user,
    required this.onTapUser,
  }) : super(key: key);

  final User user;
  final VoidCallback onTapUser;

  static const _titlePadding = EdgeInsets.only(
    left: 20,
    top: 20,
    right: 20,
  );
  static const _listItemPadding = EdgeInsets.only(left: 8, right: 8);
  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: _titlePadding,
          child: Text(
            appLocalizations.chatSettingsTitle,
            style: theme.styles.subtitle40,
          ),
        ),
        Padding(
          padding: _listItemPadding,
          child: PicnicListItem(
            onTap: onTapUser,
            title: user.username,
            titleStyle: theme.styles.body30,
            leading: PicnicAvatar(
              size: _avatarSize,
              boxFit: PicnicAvatarChildBoxFit.cover,
              backgroundColor: theme.colors.lightBlue.shade200,
              imageSource: PicnicImageSource.url(
                user.profileImageUrl,
                width: _avatarSize,
                height: _avatarSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Divider(color: blackAndWhite.shade400),
      ],
    );
  }
}
