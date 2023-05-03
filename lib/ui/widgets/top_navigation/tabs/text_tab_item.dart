import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/utils/extensions/color_extensions.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

// Just a text button that takes role in PicnicTextBar
class TextTabItem extends StatelessWidget {
  const TextTabItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.isActive,
    this.titleColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final bool isActive;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final titleStyle = theme.styles.title10.copyWith(color: titleColor ?? theme.colors.blackAndWhite.shade100);

    final color = titleStyle.color?.withOpacity(
      isActive ? Constants.fullOpacityValue : Constants.lowOpacityValue,
    );
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: titleStyle.copyWith(
          fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          color: color,
          shadows: [
            if (color?.isLightColor == true) PostOverlayPage.textShadow(context, opacity: color?.opacity),
          ],
        ),
      ),
    );
  }
}
