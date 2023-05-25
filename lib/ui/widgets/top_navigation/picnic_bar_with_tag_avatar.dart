import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_dynamic_author.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/utils/number_formatter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicBarWithTagAvatar extends StatelessWidget {
  const PicnicBarWithTagAvatar({
    Key? key,
    required this.avatar,
    required this.viewsCount,
    required this.tag,
    required this.title,
    this.date,
    this.titleBadge,
    required this.onTitleTap,
    this.titleColor,
    this.viewsCountColor,
    this.showShadowForLightColor = false,
    this.avatarPadding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.titlePadding = EdgeInsets.zero,
    this.showViewCountAtEnd = false,
  }) : super(key: key);

  final PicnicAvatar avatar;
  final PicnicTag? tag;

  final String title;
  final String? date;
  final Widget? titleBadge;
  final VoidCallback? onTitleTap;
  final EdgeInsets titlePadding;

  /// whether to show shadow behind text for light color fonts
  final bool showShadowForLightColor;

  final int viewsCount;
  final Color? viewsCountColor;
  final Color? titleColor;
  final EdgeInsets avatarPadding;
  final bool showViewCountAtEnd;

  static const _opacityValueWhite = 0.7;
  static const double _iconScale = 3.5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final white = titleColor ?? theme.colors.blackAndWhite.shade100;
    final whiteWithOpacity = white.withOpacity(_opacityValueWhite);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PicnicDynamicAuthor(
              avatar: avatar,
              username: title,
              date: date,
              usernameBadge: titleBadge,
              usernamePadding: titlePadding,
              onUsernameTap: onTitleTap,
              viewsCount: viewsCount,
              titleColor: titleColor,
              avatarPadding: avatarPadding,
            ),
          ),
          if (tag != null || showViewCountAtEnd)
            Column(
              children: [
                Image.asset(
                  Assets.images.arrowRightTwo.path,
                  color: viewsCountColor ?? whiteWithOpacity,
                  scale: _iconScale,
                ),
                Text(
                  formatNumber(viewsCount),
                  style: theme.styles.body10.copyWith(
                    color: viewsCountColor ?? whiteWithOpacity,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
