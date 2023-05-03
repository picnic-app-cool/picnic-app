import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/utils/extensions/responsive_extensions.dart';
import 'package:picnic_app/utils/extensions/string_ellipsis.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.onTap,
    required this.title,
    this.shouldBeCentered = false,
    this.overlayTheme = PostOverlayTheme.dark,
  });

  final VoidCallback onTap;
  final String title;
  final bool shouldBeCentered;
  final PostOverlayTheme overlayTheme;

  static const double _iconSizeAddition = 8;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    final textStyle = styles.body30.copyWith(
      color: overlayTheme == PostOverlayTheme.light ? theme.colors.blackAndWhite.shade100 : null,
      fontSize: context.responsiveValue(
        small: 14,
        medium: 16,
        large: 20,
      ),
      shadows: [
        if (overlayTheme == PostOverlayTheme.light) PostOverlayPage.textShadow(context),
      ],
    );

    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: shouldBeCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              title.tight(),
              style: textStyle,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: textStyle.color,
            size: (textStyle.fontSize ?? 0) + _iconSizeAddition,
          ),
        ],
      ),
    );
  }
}
