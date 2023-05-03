import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RoleItem extends StatelessWidget {
  const RoleItem({
    Key? key,
    required this.roleName,
    required this.roleEmoji,
    required this.titleStyle,
    required this.trailing,
    this.onTap,
  }) : super(key: key);

  final Widget? trailing;

  final String roleName;
  final String roleEmoji;
  final TextStyle titleStyle;
  final VoidCallback? onTap;

  static const _avatarSize = 40.0;
  static const _roleItemHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final _picnicAvatar = PicnicAvatar(
      backgroundColor: blackAndWhite.shade200,
      size: _avatarSize,
      imageSource: PicnicImageSource.emoji(
        roleEmoji,
        style: theme.styles.title10.copyWith(fontSize: 20.0),
      ),
      placeholder: () => DefaultAvatar.user(),
    );

    return PicnicListItem(
      height: _roleItemHeight,
      leftGap: 0,
      subTitleStyle: theme.styles.caption10,
      leading: _picnicAvatar,
      title: roleName,
      trailing: trailing,
      titleStyle: titleStyle,
      onTap: onTap,
    );
  }
}
