import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/utils/extensions/color_extensions.dart';
import 'package:picnic_app/utils/number_formatter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

/// Dynamic component for author and comment
/// [comment] is a nullable parameter, if [comment] != null, the component becomes an individual comment component
/// Else it will pick up the [postDetails] and show it as the Author component
/// [postDetails] is now not required, its default value is set to zero which won't be required if [comment] is not null
class PicnicDynamicAuthor extends StatelessWidget {
  const PicnicDynamicAuthor({
    Key? key,
    required this.authorUsername,
    required this.circleName,
    required this.onAuthorUsernameTap,
    this.date,
    this.authorVerifiedBadge,
    this.avatar,
    this.viewsCount = 0,
    this.comment,
    this.circleNameColor,
    this.commentColor,
    this.showShadowForLightColor = false,
    this.avatarPadding = const EdgeInsets.only(right: 8.0),
    this.usernamePadding = EdgeInsets.zero,
    this.postDetails,
    this.subtitleColor,
    this.onTapFollow,
    this.iFollow = false,
    this.onCircleTap,
  }) : super(key: key);

  final Widget? avatar;
  final String authorUsername;
  final String circleName;
  final String? date;
  final Widget? authorVerifiedBadge;
  final VoidCallback? onAuthorUsernameTap;
  final VoidCallback? onCircleTap;
  final VoidCallback? onTapFollow;
  final bool iFollow;
  final String? comment;
  final Color? circleNameColor;
  final Color? subtitleColor;
  final Color? commentColor;
  final int viewsCount;
  final Widget? postDetails;
  final EdgeInsets avatarPadding;
  final EdgeInsets usernamePadding;

  /// whether to show shadow behind text for light color fonts
  final bool showShadowForLightColor;

  static const double _opacityValueWhite = 0.7;
  static const double _followButtonHeight = 26.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final whiteColor = theme.colors.blackAndWhite.shade100;
    final circleColor = circleNameColor ?? whiteColor;
    final whiteWithOpacity = circleColor.withOpacity(_opacityValueWhite);
    final datesViewsColor = subtitleColor ?? whiteWithOpacity;
    final commentColor = this.commentColor ?? whiteColor;
    final styles = theme.styles;
    final caption10Style = styles.caption10;
    final subtitleStyle = styles.caption10.copyWith(color: datesViewsColor);
    final darkBlue = theme.colors.darkBlue;
    final tappableUsernameRadius = BorderRadius.circular(10);
    final dateToDisplay = date != null ? '$date  • ' : '';

    return Row(
      children: [
        if (avatar != null)
          Padding(
            padding: avatarPadding,
            child: avatar,
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
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
                    child: Row(
                      children: [
                        InkWell(
                          onTap: onCircleTap,
                          child: RichText(
                            text: TextSpan(
                              text: circleName,
                              style: styles.link15.copyWith(
                                color: circleColor,
                                shadows: [
                                  if (showShadowForLightColor && circleColor.isLightColor)
                                    PostOverlayPage.textShadow(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: onAuthorUsernameTap,
                            child: RichText(
                              text: TextSpan(
                                text: authorUsername,
                                style: styles.subtitle10.copyWith(
                                  color: subtitleColor,
                                  shadows: [
                                    if (showShadowForLightColor && circleColor.isLightColor)
                                      PostOverlayPage.textShadow(context),
                                  ],
                                ),
                                children: [
                                  if (authorVerifiedBadge != null) ...[
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 4,
                                        height: 0,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: authorVerifiedBadge!,
                                    ),
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 2,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
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
                  postDetails ??
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dateToDisplay + appLocalizations.viewsCount(formatNumber(viewsCount)),
                              style: subtitleStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
        if (onTapFollow != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: SizedBox(
              height: _followButtonHeight,
              child: PicnicButton(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                opacity: 1,
                title: iFollow ? appLocalizations.followingAction : appLocalizations.followAction,
                onTap: onTapFollow,
                titleStyle: styles.link15.copyWith(color: darkBlue.shade800),
                color: darkBlue.shade300,
              ),
            ),
          ),
      ],
    );
  }
}
