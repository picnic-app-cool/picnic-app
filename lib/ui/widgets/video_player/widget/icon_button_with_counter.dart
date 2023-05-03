import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    super.key,
    required this.onTap,
    required this.iconPath,
    this.counterText,
    required this.overlayTheme,
    this.isSelected = false,
    this.isLoading = false,
  });

  final VoidCallback? onTap;
  final String? counterText;
  final PostOverlayTheme overlayTheme;
  final String iconPath;
  final bool isSelected;
  final bool isLoading;

  static const _blur = 8.0;
  static const _lightOpacity = 0.1;
  static const _darkOpacity = 0.05;
  static const _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final Color backgroundColor;
    final Color foregroundColor;
    final Color textColor;
    final double opacity;
    switch (overlayTheme) {
      case PostOverlayTheme.dark:
        backgroundColor = isSelected ? colors.blue.shade800 : colors.darkBlue.shade600;
        foregroundColor = isSelected ? colors.blackAndWhite.shade100 : colors.darkBlue.shade600;
        textColor = colors.darkBlue.shade600;
        opacity = _darkOpacity;
        break;
      case PostOverlayTheme.light:
        backgroundColor = isSelected ? colors.blue.shade800 : colors.blackAndWhite.shade100;
        foregroundColor = colors.blackAndWhite.shade100;
        textColor = colors.blackAndWhite.shade100;
        opacity = _lightOpacity;
        break;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _blur,
          sigmaY: _blur,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            color: backgroundColor.withOpacity(isSelected ? 1 : opacity),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: isLoading
                  ? const PicnicLoadingIndicator(color: Colors.white)
                  : Row(
                      children: [
                        Image.asset(
                          iconPath,
                          color: foregroundColor,
                          height: _iconSize,
                          width: _iconSize,
                        ),
                        const Spacer(),
                        Text(
                          counterText?.toString() ?? '0',
                          style: theme.styles.body0.copyWith(color: textColor),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
