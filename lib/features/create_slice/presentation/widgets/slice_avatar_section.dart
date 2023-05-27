import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class SliceAvatarSection extends StatelessWidget {
  SliceAvatarSection({
    required this.onTapAvatarEdit,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapAvatarEdit;
  final String imagePath;

  static const _avatarSize = 83.0;
  static const _defaultImageSize = 35.0;
  final _defaultImagePath = Assets.images.watermelon2.path;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final bgColor = theme.colors.pink.shade200;
    final picnicAvatar = imagePath.isEmpty
        ? PicnicAvatar(
            backgroundColor: bgColor,
            imageSource: PicnicImageSource.asset(
              ImageUrl(_defaultImagePath),
              width: _defaultImageSize,
              height: _defaultImageSize,
            ),
            size: _avatarSize,
          )
        : PicnicAvatar(
            imageSource: PicnicImageSource.file(
              File(imagePath),
              width: _avatarSize,
              height: _avatarSize,
              fit: BoxFit.cover,
            ),
            boxFit: PicnicAvatarChildBoxFit.cover,
            size: _avatarSize,
          );
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          picnicAvatar,
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _AvatarEditButton(
                onTap: onTapAvatarEdit,
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
      color: PicnicTheme.of(context).colors.blue,
    );
  }
}
