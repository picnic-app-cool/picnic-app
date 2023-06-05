import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// Due to their similarity in structure , [PicnicListItem] is used for Notifications , Circles, Seeds Percentage, and List Items (see figma)
///
/// The [trailing] parameter accepts type widget (or null). See /widgetbook for the various "Options"
///
/// [subTitle] is a nullable parameter, if [subTitle] != null and [picnicTag] == null, it shows
///
/// [picnicTag] is a nullable parameter, if [picnicTag] != null and [subTitle] == null, it shows
///
/// [title] and [PicnicAvatar] are required
///
/// if [subTitle] is provided but no [subTitleStyle] [subTitle] will be set to a default style
///
/// if [fillColor] is null then background of lit item is transparent

class PicnicListItem extends StatelessWidget {
  const PicnicListItem({
    Key? key,
    required this.title,
    this.titleBadge,
    this.titleGap = _titleGap,
    this.onTap,
    this.onTapDetails,
    this.height = _height,
    this.borderColor,
    this.subTitle,
    this.subTitleSpan,
    this.trailing,
    required this.titleStyle,
    this.subTitleStyle,
    this.leading,
    this.setBoxShadow = false,
    this.picnicTag,
    this.fillColor,
    this.borderRadius = _borderRadius,
    this.leftGap = _leftGap,
    this.trailingGap = _trailingGap,
    this.titleTextOverflow,
    this.maxLines = _titleMaxLines,
    this.subtitleMaxLines,
    this.subtitleTextOverflow,
    this.subTitleSpanStyle = const TextStyle(),
    this.opacity = _defaultOpacity,
    this.borderWidth = _borderWidth,
  }) : super(key: key);

  final String title;
  final TextStyle titleStyle;
  final Widget? titleBadge;
  final double titleGap;
  final TextOverflow? titleTextOverflow;

  final String? subTitle;
  final String? subTitleSpan;
  final PicnicTag? picnicTag;

  final TextStyle? subTitleStyle;
  final TextStyle? subTitleSpanStyle;
  final TextOverflow? subtitleTextOverflow;

  final Widget? trailing;
  final Widget? leading;

  final VoidCallback? onTap;
  final VoidCallback? onTapDetails;
  final double? height;
  final Color? borderColor;
  final double borderRadius;

  final int maxLines;
  final int? subtitleMaxLines;
  final Color? fillColor;
  final bool setBoxShadow;

  final double leftGap;
  final double trailingGap;

  final double opacity;
  final double borderWidth;

  static const _leftGap = 16.0;
  static const _trailingGap = 16.0;
  static const _borderWidth = 3.0;
  static const _borderRadius = 8.0;
  static const _titleGap = 8.0;
  static const _titleMaxLines = 1;
  static const _defaultOpacity = 1.0;

  static const _height = 75.0;

  /// The blur radius applied to box shadow of [PicnicListItem] component.
  static const _blurRadius = 8.0;

  /// The shadow opacity applied to box shadow of [PicnicListItem] component.
  static const _boxShadowOpacity = 0.05;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final blackAndWhiteColor = colors.blackAndWhite;
    final textStyleCaption20 = theme.styles.caption20;

    var subtitleStyle = subTitleStyle;

    subtitleStyle ??= textStyleCaption20;

    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            boxShadow: setBoxShadow
                ? [
                    BoxShadow(
                      blurRadius: _blurRadius,
                      color: blackAndWhiteColor.shade900.withOpacity(_boxShadowOpacity),
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
            color: fillColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null ? Border.all(width: borderWidth, color: borderColor!) : null,
          ),
          child: Row(
            children: [
              Gap(leftGap),
              if (leading != null) leading!,
              Gap(titleGap),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: RichText(
                        maxLines: maxLines,
                        overflow: titleTextOverflow ?? TextOverflow.clip,
                        text: TextSpan(
                          text: title,
                          style: titleStyle,
                          children: [
                            if (titleBadge != null) ...[
                              const WidgetSpan(
                                child: SizedBox(
                                  width: 4,
                                  height: 0,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: titleBadge!,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (subTitle != null && picnicTag == null)
                      RichText(
                        maxLines: subtitleMaxLines,
                        overflow: subtitleTextOverflow ?? TextOverflow.clip,
                        text: TextSpan(
                          text: subTitle,
                          style: subtitleStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: subTitleSpan,
                              style: subTitleSpanStyle,
                            ),
                          ],
                        ),
                      ),
                    if (subTitle == null && picnicTag != null) picnicTag!,
                  ],
                ),
              ),
              if (trailing != null) ...[
                InkWell(
                  onTap: onTapDetails,
                  child: trailing,
                ),
                Gap(trailingGap),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
