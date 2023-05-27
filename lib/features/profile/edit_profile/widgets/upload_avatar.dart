import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class UploadAvatar extends StatelessWidget {
  const UploadAvatar({
    required this.imageSource,
  });

  final PicnicImageSource imageSource;

  static const _avatarSize = 100.0;
  static const _maxRadius = 14.0;
  static const _scale = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final lightBlue = theme.colors.lightBlue;
    final blue = theme.colors.blue;
    final white = theme.colors.blackAndWhite.shade100;

    final avatar = PicnicAvatar(
      backgroundColor: lightBlue.shade200,
      boxFit: PicnicAvatarChildBoxFit.cover,
      imageSource: imageSource,
    );

    return Stack(
      children: [
        avatar,
        SizedBox(
          width: _avatarSize,
          height: _avatarSize,
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              maxRadius: _maxRadius,
              backgroundColor: blue,
              child: Image.asset(
                Assets.images.edit.path,
                scale: _scale,
                color: white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
