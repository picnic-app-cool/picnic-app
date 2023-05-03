import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_like_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostBarLikeButton extends StatelessWidget {
  const PostBarLikeButton({
    required this.params,
    super.key,
  });

  final PostBarLikeButtonParams params;

  @override
  Widget build(BuildContext context) {
    final Color textColor;
    final Color? foregroundColor;

    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    switch (params.overlayTheme) {
      case PostOverlayTheme.dark:
        textColor = colors.darkBlue.shade600;
        foregroundColor = colors.darkBlue.shade600;
        break;
      case PostOverlayTheme.light:
        textColor = colors.blackAndWhite.shade100;
        foregroundColor = null;
        break;
    }

    final children = <Widget>[
      PicnicLikeButton(
        isLiked: params.isLiked,
        onTap: params.onTap,
        image: params.overlayTheme == PostOverlayTheme.light
            ? Assets.images.heart
            : params.isVertical
                ? Assets.images.heartOutlined
                : Assets.images.heartOutlinedMedium,
        size: params.isVertical ? PostBarButton.iconSize(context) : PostBarButton.horizontalIconSize(context),
        strokeColor: foregroundColor,
      ),
      if (!params.isVertical) const Gap(8),
      Text(
        params.likes,
        style: theme.styles.body0.copyWith(
          color: textColor,
          fontSize: params.isVertical ? PostBarButton.defaultFontSize : PostBarButton.fontSize(context),
          shadows: [
            if (params.overlayTheme == PostOverlayTheme.light) PostOverlayPage.textShadow(context),
          ],
        ),
      ),
    ];

    return GestureDetector(
      onTap: params.onTap,
      child: Container(
        width: params.isVertical ? null : params.width,
        padding: params.isVertical ? null : const EdgeInsets.symmetric(vertical: 16),
        color: Colors.transparent,
        child: params.isVertical
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
      ),
    );
  }
}
