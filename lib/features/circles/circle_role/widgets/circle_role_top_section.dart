import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class CircleRoleTopSection extends StatelessWidget {
  const CircleRoleTopSection({
    required this.onTapEditEmoji,
    required this.emoji,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapEditEmoji;
  final String emoji;

  static const _emojiSize = 45.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PicnicAvatar(
            backgroundColor: theme.colors.blackAndWhite.shade200,
            imageSource: PicnicImageSource.emoji(
              emoji,
              style: theme.styles.title40.copyWith(
                fontSize: _emojiSize,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _AvatarEditButton(
                onTap: onTapEditEmoji,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarEditButton extends StatelessWidget {
  const _AvatarEditButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  static const _iconSize = 15.0;
  static const _buttonSize = 34.0;

  @override
  Widget build(BuildContext context) {
    return PicnicIconButton(
      icon: Assets.images.repeat.path,
      iconSize: _iconSize,
      size: _buttonSize,
      onTap: onTap,
      color: PicnicTheme.of(context).colors.green,
    );
  }
}
