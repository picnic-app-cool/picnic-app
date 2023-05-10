import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_like_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LikeDislikeButtonWithCounter extends StatelessWidget {
  const LikeDislikeButtonWithCounter({
    Key? key,
    required this.isLiked,
    required this.likes,
    required this.onTapLike,
    required this.onTapDislike,
    required this.isDisliked,
  }) : super(key: key);

  final bool isLiked;
  final bool isDisliked;
  final String likes;
  final Function() onTapLike;
  final Function() onTapDislike;

  static const _lightOpacity = 0.1;
  static const _blur = 8.0;
  static const _likeDislikeIconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color textColor;

    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final double opacity;
    final white = colors.blackAndWhite.shade100;
    final darkBlue = colors.darkBlue.shade600;
    backgroundColor = white;
    textColor = white;
    opacity = _lightOpacity;
    final foregroundLikeColor = isLiked ? darkBlue : white;
    final foregroundDislikeColor = isDisliked ? darkBlue : white;

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
                  onTap: onTapLike,
                  size: _likeDislikeIconSize,
                  strokeColor: foregroundLikeColor,
                  image: Assets.images.likeFilled,
                ),
                const Gap(4),
                Text(
                  likes,
                  style: theme.styles.body0.copyWith(color: textColor),
                ),
                const Gap(4),
                GestureDetector(
                  onTap: onTapDislike,
                  child: Image.asset(
                    Assets.images.dislikeFilled.path,
                    color: foregroundDislikeColor,
                    height: _likeDislikeIconSize,
                    width: _likeDislikeIconSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
