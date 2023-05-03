import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VerifiedAvatar extends StatelessWidget {
  const VerifiedAvatar({
    required this.avatarSize,
    required this.imagePath,
  });

  final double avatarSize;
  final String imagePath;

  static const _blurRadius = 30.0;
  static const _boxShadowOpacity = 0.2;
  static const _badgeSize = 30.0;
  static const _blurOffset = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blueColor = theme.colors.blue;

    final containerSize = avatarSize + _blurRadius / 2;

    final avatar = PicnicAvatar(
      size: avatarSize,
      backgroundColor: Colors.white,
      boxFit: PicnicAvatarChildBoxFit.cover,
      imageSource: PicnicImageSource.asset(
        ImageUrl(imagePath),
        width: avatarSize,
        height: avatarSize,
      ),
    );

    return Stack(
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: _blurRadius,
                color: blueColor.withOpacity(_boxShadowOpacity),
                offset: const Offset(0, _blurOffset),
              ),
            ],
          ),
          child: Stack(
            children: [
              avatar,
              SizedBox(
                width: avatarSize,
                height: avatarSize,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Assets.images.achievement.image(width: _badgeSize),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
