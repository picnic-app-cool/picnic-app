import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_user_avatar_button/post_bar_user_avatar_button_params.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/defer_pointer/defer_pointer.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostBarUserAvatarButton extends StatelessWidget {
  const PostBarUserAvatarButton({
    required this.params,
    super.key,
  });

  final PostBarUserAvatarButtonParams params;

  static const _avatarSize = 48.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final deferredLink = DeferredPointerHandlerLink();

    return DeferredPointerHandler(
      link: deferredLink,
      child: PicnicAvatar(
        size: _avatarSize,
        backgroundColor: colors.blue.shade100,
        borderColor: Colors.white,
        iFollow: params.iFollow,
        onToggleFollow: params.onTapFollow,
        onTap: params.onTapAvatar,
        placeholder: () => DefaultAvatar.user(),
        imageSource: PicnicImageSource.url(
          ImageUrl(params.userAvatar),
          fit: BoxFit.cover,
        ),
        deferredLink: deferredLink,
        shouldShowFollowButton: true,
        boxFit: PicnicAvatarChildBoxFit.cover,
      ),
    );
  }
}
