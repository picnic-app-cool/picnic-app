import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/utils/extensions/responsive_extensions.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostBarButton extends StatelessWidget {
  const PostBarButton({
    required this.params,
    this.decoration,
    super.key,
  });

  final PostBarButtonParams params;
  final BoxDecoration? decoration;

  static const defaultFontSize = 12.0;

  static const _iconSizeSmall = 28.0;
  static const _iconSizeMedium = 30.0;
  static const _iconSizeLarge = 32.0;

  static const _horizontalIconSizeSmall = 22.0;
  static const _horizontalIconSizeMedium = 24.0;
  static const _horizontalIconSizeLarge = 26.0;

  static const _fontSizeSmall = 12.0;
  static const _fontSizeMedium = 14.0;
  static const _fontSizeLarge = 16.0;

  static double iconSize(BuildContext context) => context.responsiveValue(
        small: _iconSizeSmall,
        medium: _iconSizeMedium,
        large: _iconSizeLarge,
      );

  static double horizontalIconSize(BuildContext context) => context.responsiveValue(
        small: _horizontalIconSizeSmall,
        medium: _horizontalIconSizeMedium,
        large: _horizontalIconSizeLarge,
      );

  static double fontSize(BuildContext context) => context.responsiveValue(
        small: _fontSizeSmall,
        medium: _fontSizeMedium,
        large: _fontSizeLarge,
      );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final Color foregroundColor;
    final Color textColor;

    switch (params.overlayTheme) {
      case PostOverlayTheme.dark:
        foregroundColor = colors.darkBlue.shade600;
        textColor = colors.darkBlue.shade600;
        break;
      case PostOverlayTheme.light:
        foregroundColor =
            params.selected ? colors.darkBlue.shade600 : (params.lightIconColor ?? colors.blackAndWhite.shade100);
        textColor = colors.blackAndWhite.shade100;
        break;
    }

    final topAvatarSize = params.isVertical ? iconSize(context) : horizontalIconSize(context);
    final children = <Widget>[
      Container(
        decoration: decoration,
        child: Image.asset(
          params.overlayTheme == PostOverlayTheme.light
              ? params.filledIcon!
              : params.selected
                  ? params.filledIcon!
                  : params.outlinedIcon!,
          width: topAvatarSize,
          height: topAvatarSize,
          color: foregroundColor == Colors.transparent ? null : foregroundColor,
        ),
      ),
      if (!params.isVertical) const Gap(2),
      if (params.text != null)
        Text(
          params.text ?? '',
          style: theme.styles.subtitle40.copyWith(
            color: textColor,
            fontSize: params.isVertical ? defaultFontSize : fontSize(context),
            shadows: [
              if (params.overlayTheme == PostOverlayTheme.light) PostOverlayPage.textShadow(context),
            ],
          ),
        )
      else
        const SizedBox(height: 4),
    ];
    return GestureDetector(
      onTap: params.onTap,
      child: Container(
        width: params.isVertical ? null : params.width,
        color: Colors.transparent,
        child: params.isVertical
            ? Column(
                children: children,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
      ),
    );
  }
}
