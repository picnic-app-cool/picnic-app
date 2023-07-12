import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCircleRectangleAvatar extends StatelessWidget {
  const PicnicCircleRectangleAvatar({
    required this.avatarSize,
    required this.emojiSize,
    //ignore: no-magic-number
    this.verifiedBadgeSize = 18.0,
    this.image = '',
    this.emoji = '😃',
    this.bgColor,
    this.borderColor,
    this.isVerified = false,
    this.onTap,
    super.key,
  });

  final String image;
  final String emoji;
  final double avatarSize;
  final double emojiSize;
  final double verifiedBadgeSize;
  final Color? bgColor;
  final Color? borderColor;
  final bool isVerified;
  final VoidCallback? onTap;

  static const _borderRadius = 4.0;
  static const _borderWidth = 1.5;
  static const _avatarPadding = 6.0;
  static const _emojiHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final darkBlueShade200 = theme.colors.darkBlue;
    final avatarBgColor = bgColor ?? darkBlueShade200;
    final avatarBorderColor = borderColor ?? darkBlueShade200;
    final verifiedBadge = Assets.images.verBadge.path;
    final avatarContainerSize = avatarSize + _avatarPadding;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: avatarContainerSize,
        height: avatarContainerSize,
        child: Stack(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
                border: Border.all(width: _borderWidth, color: avatarBorderColor),
                color: avatarBgColor,
              ),
              child: Center(
                child: image.isNotEmpty
                    ? Image.network(
                        image,
                        width: avatarSize,
                        height: avatarSize,
                        fit: BoxFit.cover,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          emoji,
                          style: theme.styles.title40.copyWith(
                            fontSize: emojiSize,
                            height: _emojiHeight,
                          ),
                        ),
                      ),
              ),
            ),
            if (isVerified)
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  verifiedBadge,
                  height: verifiedBadgeSize,
                  width: verifiedBadgeSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
