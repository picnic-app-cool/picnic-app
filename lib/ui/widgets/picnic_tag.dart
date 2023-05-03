import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/utils/extensions/string_ellipsis.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// [PicnicTag]
/// To include text emojis in the tag, include the emoji string as part of [title]
///
/// If [blurRadius] is set to null, the glass effect is removed

class PicnicTag extends StatelessWidget {
  const PicnicTag({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.prefixIcon,
    this.style = PicnicTagStyle.filled,
    this.borderWidth = 0,
    this.padding = const EdgeInsets.only(
      left: 10.0,
      right: 10.0,
      top: 6.0,
      bottom: 6.0,
    ),
    this.borderColor,
    this.borderRadius = _defaultBorderRadius,
    this.suffixIcon,
    this.iconSize = _defaultIconSize,
    this.onTap,
    this.onSuffixTap,
    this.blurRadius = _tagBlurRadius,
    this.opacity,
    this.titleTextStyle,
  }) : super(key: key);

  final String title;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final PicnicTagStyle style;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixTap;

  final double borderWidth;
  final double iconSize;
  final TextStyle? titleTextStyle;

  final EdgeInsets padding;
  final double borderRadius;
  final double? opacity;

  /// The blur radius is optional .
  final double? blurRadius;

  static const double _tagBlurRadius = 8.0;
  static const _defaultBorderRadius = 12.0;

  static const double _defaultOpacity = 0.3;
  static const double _defaultIconSize = 16;

  @override
  Widget build(BuildContext context) {
    final opacityColor = backgroundColor?.withOpacity(opacity ?? _defaultOpacity);
    final tag = _Tag(
      padding: padding,
      backgroundColor: blurRadius != null ? opacityColor : backgroundColor,
      borderRadius: borderRadius,
      style: style,
      titleTextStyle: titleTextStyle,
      borderWidth: borderWidth,
      borderColor: borderColor,
      prefixIcon: prefixIcon,
      iconSize: iconSize,
      title: title,
      suffixIcon: suffixIcon,
      onTap: onTap,
      onSuffixTap: onSuffixTap,
    );
    return blurRadius != null

        ///ClipRRect is needed else the filter will be applied to the whole screen
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurRadius!,
                sigmaY: blurRadius!,
              ),
              child: tag,
            ),
          )
        : tag;
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    Key? key,
    required this.padding,
    required this.backgroundColor,
    this.borderRadius = defaultBorderRadius,
    required this.style,
    this.borderWidth = defaultBorderWidth,
    required this.borderColor,
    this.prefixIcon,
    this.iconSize = defaultIconSize,
    required this.title,
    this.suffixIcon,
    this.titleTextStyle,
    this.onTap,
    this.onSuffixTap,
  }) : super(key: key);

  final EdgeInsets padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final PicnicTagStyle style;
  final double borderWidth;
  final Color? borderColor;
  final Widget? prefixIcon;
  final double iconSize;
  final String title;
  final TextStyle? titleTextStyle;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixTap;

  final Widget? suffixIcon;

  static const defaultIconSize = 16.0;
  static const defaultBorderRadius = 12.0;
  static const defaultBorderWidth = 0.5;

  @override
  Widget build(BuildContext context) {
    final prefixIconExists = prefixIcon != null;
    final suffixIconExists = suffixIcon != null;

    final theme = PicnicTheme.of(context);
    final textStyleTitle10 = theme.styles.title10.copyWith(
      color: theme.colors.blackAndWhite.shade100,
      fontWeight: FontWeight.bold,
    );

    var tagTitleStyle = titleTextStyle;

    tagTitleStyle ??= textStyleTitle10;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          borderRadius!,
        ),
        border: style != PicnicTagStyle.filled
            ? Border.all(
                width: borderWidth,
                color: borderColor!,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIconExists) ...[
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: FittedBox(child: prefixIcon),
            ),
            const Gap(8),
          ],
          Flexible(
            child: InkWell(
              onTap: onTap,
              child: Text(
                title.tight(),
                style: tagTitleStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          if (suffixIconExists) ...[
            const Gap(8),
            InkWell(
              onTap: onSuffixTap,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: iconSize,
                  maxWidth: iconSize,
                ),
                child: suffixIcon,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum PicnicTagStyle { outlined, filled }
