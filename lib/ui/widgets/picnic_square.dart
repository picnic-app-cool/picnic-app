import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// [PicnicSquare]
///
/// If [isRoyalty] is true, it sets the border color of the square gold and sets isCrowned true for [PicnicAvatar]
///

class PicnicSquare extends StatelessWidget {
  const PicnicSquare({
    Key? key,
    this.borderColor,
    this.onTapEnterCircle,
    required this.emoji,
    required this.imagePath,
    required this.title,
    this.isRoyalty = false,
    required this.titleStyle,
    this.subTitle,
    this.borderRadius = _borderRadius,
    this.avatarBackgroundColor,
    this.onLongPress,
  }) : super(key: key);

  final Color? borderColor;
  final VoidCallback? onTapEnterCircle;
  final String emoji;
  final String imagePath;
  final String title;
  final Color? avatarBackgroundColor;
  final double borderRadius;
  final VoidCallback? onLongPress;

  final TextStyle titleStyle;
  final String? subTitle;

  /// [isRoyalty] sets the border of the of [PicnicSquare] gold and adds a crown to the [PicnicAvatar] component.
  final bool isRoyalty;

  static const height = 110.0;
  static const _width = 103.0;

  static const _borderWidth = 3.0;
  static const _borderRadius = 8.0;

  /// The blur radius applied to box shadow of [PicnicSquare] component.
  static const _blurRadius = 8.0;

  /// The shadow opacity applied to box shadow of [PicnicSquare] component.
  static const _boxShadowOpacity = 0.05;

  /// The size applied to the [PicnicAvatar] component.
  static const _picnicAvatarSize = 48.0;

  static const _emojiSize = 24.0;
  static const _maxLines = 2;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    var circleBorderColor = borderColor;

    if (isRoyalty) {
      circleBorderColor = colors.yellow;
    }
    final blackAndWhiteColor = colors.blackAndWhite;
    return SizedBox(
      width: _width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: _blurRadius,
                  color: blackAndWhiteColor.shade900.withOpacity(_boxShadowOpacity),
                  offset: const Offset(0, 2),
                ),
              ],
              border: circleBorderColor != null ? Border.all(width: _borderWidth, color: circleBorderColor) : null,
              color: blackAndWhiteColor.shade100,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                PicnicCircleAvatar(
                  emoji: emoji,
                  image: imagePath,
                  avatarSize: _picnicAvatarSize,
                  emojiSize: _emojiSize,
                  bgColor: avatarBackgroundColor,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                    maxLines: _maxLines,
                  ),
                ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: theme.styles.caption10,
                  ),
                const Spacer(),
              ],
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(borderRadius),
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTapEnterCircle,
              onLongPress: onLongPress,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ],
      ),
    );
  }
}
