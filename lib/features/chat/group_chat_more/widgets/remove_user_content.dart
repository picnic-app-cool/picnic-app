import 'package:flutter/cupertino.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RemoveUserContent extends StatelessWidget {
  const RemoveUserContent({super.key, required this.user});

  final User user;

  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final _avatar = PicnicAvatar(
      size: _avatarSize,
      boxFit: PicnicAvatarChildBoxFit.cover,
      backgroundColor: PicnicColors.primaryButtonBlue,
      imageSource: PicnicImageSource.url(
        user.profileImageUrl,
        fit: BoxFit.cover,
      ),
    );

    return PicnicListItem(
      title: user.username,
      leading: _avatar,
      titleStyle: theme.styles.subtitle20,
    );
  }
}
