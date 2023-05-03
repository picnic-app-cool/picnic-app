import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/utils/extensions/color_extensions.dart';
import 'package:picnic_app/utils/number_formatter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// Dynamic component for author and comment
/// [comment] is a nullable parameter, if [comment] != null, the component becomes an individual comment component
/// Else it will pick up the [tag] and show it as the Author component
/// [tag] is now not required, its default value is set to zero which won't be required if [comment] is not null
class PicnicDynamicAuthor extends StatelessWidget {
  const PicnicDynamicAuthor({
    Key? key,
    required this.username,
    this.date,
    this.usernameBadge,
    required this.onUsernameTap,
    this.avatar,
    this.viewsCount = 0,
    this.comment,
    this.titleColor,
    this.commentColor,
    this.showShadowForLightColor = false,
    this.avatarPadding = const EdgeInsets.only(right: 8.0),
    this.usernamePadding = EdgeInsets.zero,
    this.tag,
    this.showViewCountAtEnd = false,
  }) : super(key: key);

  final PicnicAvatar? avatar;
  final String username;
  final String? date;
  final Widget? usernameBadge;
  final VoidCallback? onUsernameTap;
  final String? comment;
  final Color? titleColor;
  final Color? commentColor;
  final int viewsCount;
  final PicnicTag? tag;
  final EdgeInsets avatarPadding;
  final EdgeInsets usernamePadding;
  final bool showViewCountAtEnd;

  /// whether to show shadow behind text for light color fonts
  final bool showShadowForLightColor;

  static const double _iconScale = 3.5;
  static const _opacityValueWhite = 0.7;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final whiteColor = theme.colors.blackAndWhite.shade100;
    final textColor = titleColor ?? whiteColor;
    final whiteWithOpacity = textColor.withOpacity(_opacityValueWhite);
    final commentColor = this.commentColor ?? whiteColor;
    final styles = theme.styles;
    final caption10Style = styles.caption10;

    final tappableUsernameRadius = BorderRadius.circular(10);

    return Row(
      crossAxisAlignment: showViewCountAtEnd ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (avatar != null)
          Padding(
            padding: avatarPadding,
            child: avatar,
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: usernamePadding,
                child: Material(
                  type: MaterialType.transparency,
                  borderRadius: tappableUsernameRadius,
                  child: InkWell(
                    onTap: onUsernameTap,
                    borderRadius: tappableUsernameRadius,
                    child: Row(
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              text: username,
                              style: (showViewCountAtEnd ? styles.title10 : styles.body0).copyWith(
                                color: textColor,
                                shadows: [
                                  if (showShadowForLightColor && textColor.isLightColor)
                                    PostOverlayPage.textShadow(context),
                                ],
                              ),
                              children: [
                                if (usernameBadge != null) ...[
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width: 4,
                                      height: 0,
                                    ),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: usernameBadge!,
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width: 2,
                                      height: 0,
                                    ),
                                  ),
                                ],
                                if (date != null) ...[
                                  TextSpan(
                                    text: ' • $date',
                                    style: caption10Style.copyWith(color: whiteWithOpacity),
                                  ),
                                ],
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (comment != null)
                Text(
                  comment!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: caption10Style.copyWith(color: commentColor),
                )
              else
                tag ??
                    (showViewCountAtEnd
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              Image.asset(
                                Assets.images.arrowRightTwo.path,
                                color: whiteWithOpacity,
                                scale: _iconScale,
                              ),
                              Text(
                                formatNumber(viewsCount),
                                style: styles.body10.copyWith(color: whiteWithOpacity),
                              ),
                            ],
                          )),
            ],
          ),
        ),
      ],
    );
  }
}
