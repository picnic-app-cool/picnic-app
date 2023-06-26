import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    this.joinTextColor,
    this.onTapFollow,
    this.onTapJoinCircle,
    this.iFollow = false,
    this.iJoined = false,
    this.onCircleTap,
    this.showDateViews = true,
  }) : super(key: key);

  final Widget? avatar;
  final String authorUsername;
  final String circleName;
  final String? date;
  final Widget? authorVerifiedBadge;
  final VoidCallback? onAuthorUsernameTap;
  final VoidCallback? onCircleTap;
  final VoidCallback? onTapFollow;
  final VoidCallback? onTapJoinCircle;
  final bool iFollow;
  final bool iJoined;
  final String? comment;
  final Color? circleNameColor;
  final Color? subtitleColor;
  final Color? joinTextColor;
  final Color? commentColor;
  final int viewsCount;
  final Widget? postDetails;
  final EdgeInsets avatarPadding;
  final EdgeInsets usernamePadding;
  final bool showDateViews;

  /// whether to show shadow behind text for light color fonts
  final bool showShadowForLightColor;

  static const double _opacityValueWhite = 0.7;
  static const double _followButtonHeight = 26.0;
  static const double _joinButtonRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final whiteColor = theme.colors.blackAndWhite.shade100;
    final circleColor = circleNameColor ?? whiteColor;
    final whiteWithOpacity = circleColor.withOpacity(_opacityValueWhite);
    final datesViewsColor = subtitleColor ?? whiteWithOpacity;
    final joinButtonTextColor = joinTextColor ?? whiteColor;
    final commentColor = this.commentColor ?? whiteColor;
    final styles = theme.styles;
    final caption10Style = styles.caption10;
    final subtitleStyle = styles.body10.copyWith(color: subtitleColor);
    final darkBlue = theme.colors.darkBlue;
    final tappableUsernameRadius = BorderRadius.circular(10);
    final dateToDisplay = date?.toString() ?? '';

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
                        Flexible(
                          child: InkWell(
                            onTap: onCircleTap,
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                        ),
                        const Gap(4),
                        if (onTapJoinCircle != null)
                          InkWell(
                            onTap: onTapJoinCircle,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(_joinButtonRadius),
                                border: Border.all(
                                  color: datesViewsColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                child: Text(
                                  iJoined ? appLocalizations.joinedButtonActionTitle : appLocalizations.joinAction,
                                  style: styles.subtitle10.copyWith(color: joinButtonTextColor),
                                ),
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
                          Flexible(
                            child: InkWell(
                              onTap: onAuthorUsernameTap,
                              child: RichText(
                                text: TextSpan(
                                  text: appLocalizations.byUsername(authorUsername),
                                  style: subtitleStyle,
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
                          if (showDateViews)
                            Text(
                              ' • $dateToDisplay • ${appLocalizations.viewsCount(formatNumber(viewsCount))}',
                              style: subtitleStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
              ],
            ),
          ),
        ),
        if (onTapFollow != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 8),
            child: SizedBox(
              height: _followButtonHeight,
              child: PicnicButton(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                opacity: 1,
                title: iFollow ? appLocalizations.followingAction : appLocalizations.followAction,
                onTap: onTapFollow,
                titleStyle: styles.subtitle15.copyWith(color: darkBlue.shade800),
                color: darkBlue.shade300,
              ),
            ),
          ),
      ],
    );
  }
}
