import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicButton extends StatelessWidget {
  const PicnicButton({
    super.key,
    this.size = PicnicButtonSize.small,
    required this.title,
    this.color,
    this.icon,
    this.onTap,
    this.style = PicnicButtonStyle.filled,
    this.emoji,
    this.borderWidth = 0,
    this.borderRadius,
    this.titleColor,
    this.titleStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.minWidth,
    this.borderColor = Colors.transparent,
    this.originalIconColor = false,
    this.suffix,
    this.opacity,
  });

  final String title;
  final String? icon;
  final bool originalIconColor;
  final String? emoji;
  final PicnicButtonStyle style;
  final PicnicButtonSize size;
  final Color? color;
  final Color? titleColor;
  final Color borderColor;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final double borderWidth;
  final EdgeInsets padding;
  final double? minWidth;
  final Widget? suffix;
  final PicnicButtonRadius? borderRadius;
  final double? opacity;

  static const double opacityDisabled = .5;
  static const double iconSize = 16;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final iconExists = icon != null;
    final emojiExists = emoji != null;

    final borderRadius = BorderRadius.circular(
      this.borderRadius?.radius ?? const PicnicButtonRadius.round().radius,
    );
    return Opacity(
      opacity: opacity ?? (onTap == null ? opacityDisabled : 1),
      child: Material(
        color: color ?? (style == PicnicButtonStyle.outlined ? Colors.transparent : colors.blue),
        borderRadius: borderRadius,
        child: Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: borderRadius,
            border: style != PicnicButtonStyle.filled
                ? Border.all(
                    width: borderWidth,
                    color: borderColor,
                  )
                : null,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.zero.copyWith(top: padding.top, bottom: padding.bottom),
              constraints: minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
              child: Row(
                mainAxisSize: size == PicnicButtonSize.small ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SqueezableHorizontalPadding(width: padding.left),
                  if (iconExists) ...[
                    Image.asset(
                      icon!,
                      height: iconSize,
                      width: iconSize,
                      color: originalIconColor ? null : titleColor,
                    ),
                    const Gap(8),
                  ],
                  if (emojiExists) ...[
                    Text(
                      emoji!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Gap(4),
                  ],
                  // TODO: Picnic Button overflows when text is too long https://picnic-app.atlassian.net/browse/GS-6422
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle ??
                        theme.styles.link15.copyWith(
                          color: titleColor ?? theme.colors.blackAndWhite.shade100,
                        ),
                  ),
                  if (suffix != null) suffix!,
                  //this makes the right padding squeezable, to avoid overflow as much as possible costs
                  _SqueezableHorizontalPadding(width: padding.right),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// when added to Row, by default adds padding of [width] size, but if the constraints tighten, padding is first
/// reduced up until [width/2] before it makes the text overflow in the button
class _SqueezableHorizontalPadding extends StatelessWidget {
  const _SqueezableHorizontalPadding({
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final halfWidth = width / 2;
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: halfWidth, maxWidth: width),
        child: const SizedBox(width: double.infinity),
      ),
    );
  }
}

class PicnicButtonRadius {
  const PicnicButtonRadius({
    this.radius = _defaultRadius,
  });

  const PicnicButtonRadius.round() : radius = _defaultRadius;

  const PicnicButtonRadius.square() : radius = 0;

  const PicnicButtonRadius.semiRound() : radius = _semiRoundRadius;

  final double radius;

  ///Semi round radius for picnic button
  static const double _semiRoundRadius = 12.0;

  ///Default radius for picnic button
  static const double _defaultRadius = 999;
}

enum PicnicButtonStyle { outlined, filled }

enum PicnicButtonSize {
  small,
  large,
}
