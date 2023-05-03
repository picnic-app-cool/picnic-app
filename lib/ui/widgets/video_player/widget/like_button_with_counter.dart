import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_like_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LikeButtonWithCounter extends StatelessWidget {
  const LikeButtonWithCounter({
    Key? key,
    required this.isLiked,
    required this.likes,
    required this.overlayTheme,
    required this.onTap,
  }) : super(key: key);

  final bool isLiked;
  final String likes;
  final PostOverlayTheme overlayTheme;
  final Function() onTap;

  static const _lightOpacity = 0.1;
  static const _darkOpacity = 0.05;
  static const _blur = 8.0;
  static const _likeIconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color textColor;
    final Color foregroundColor;

    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final double opacity;
    switch (overlayTheme) {
      case PostOverlayTheme.dark:
        backgroundColor = colors.darkBlue.shade600;
        textColor = colors.darkBlue.shade600;
        opacity = _darkOpacity;
        foregroundColor = colors.darkBlue.shade600;
        break;
      case PostOverlayTheme.light:
        backgroundColor = colors.blackAndWhite.shade100;
        textColor = colors.blackAndWhite.shade100;
        opacity = _lightOpacity;
        foregroundColor = colors.blackAndWhite.shade100;
        break;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _blur,
          sigmaY: _blur,
        ),
        child: Container(
          color: backgroundColor.withOpacity(opacity),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                PicnicLikeButton(
                  isLiked: isLiked,
                  onTap: onTap,
                  size: _likeIconSize,
                  strokeColor: foregroundColor,
                ),
                const Spacer(),
                Text(
                  likes,
                  style: theme.styles.body0.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
