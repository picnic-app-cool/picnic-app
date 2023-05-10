import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_like_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicLikeHeartColumn extends StatelessWidget {
  const PicnicLikeHeartColumn({
    Key? key,
    required this.likesCount,
    required this.onTapLikeHeart,
    required this.liked,
  }) : super(key: key);

  final int likesCount;
  final bool liked;
  final VoidCallback? onTapLikeHeart;

  static const _heartIconSize = 18.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PicnicLikeButton(
          isLiked: liked,
          onTap: onTapLikeHeart,
          size: _heartIconSize,
          image: Assets.images.likeOutlined,
        ),
        Text(
          likesCount.toString(),
          style: theme.styles.body0.copyWith(color: colors.blackAndWhite.shade600),
        ),
      ],
    );
  }
}
