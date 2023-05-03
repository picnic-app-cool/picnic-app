import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';

// IF PARAMETERS REGARDING BADGE ARE NOT PASSED, IT DOESN'T DISPLAY ANYTHING REGARDING IT.

class PicnicBarWithTitleBadge extends StatelessWidget implements PreferredSizeWidget {
  const PicnicBarWithTitleBadge({
    Key? key,
    this.padding,
    required this.iconPathFirst,
    required this.onTapFirst,
    this.iconPathSecond,
    this.onTapSecond,
    this.title,
    this.titleStyle,
    this.badgeValue,
    this.badgeTextStyle,
    this.badgeTextColor,
    this.badgeBackgroundColor,
    this.badgeRadius,
    this.iconTintColor,
  }) : super(key: key);

  final EdgeInsets? padding;

  final String iconPathFirst;
  final String? iconPathSecond;

  final VoidCallback onTapFirst;
  final VoidCallback? onTapSecond;

  final String? title;
  final TextStyle? titleStyle;

  final int? badgeValue;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;
  final TextStyle? badgeTextStyle;
  final double? badgeRadius;

  final Color? iconTintColor;

  static const double _toolbarHeight = 88;

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        _toolbarHeight + MediaQuery.of(context).padding.top,
      ),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: Constants.largePadding,
                vertical: Constants.mediumPadding,
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title ?? '',
                    style: titleStyle ??
                        PicnicTheme.of(context).styles.title40.copyWith(
                              height: 1,
                            ),
                  ),
                  if (badgeValue != null)
                    Row(
                      children: [
                        const Gap(8),
                        PicnicBadge(
                          count: badgeValue!,
                          badgeBackgroundColor: badgeBackgroundColor,
                          badgeTextColor: badgeTextColor,
                          badgeStyle: badgeTextStyle,
                          badgeRadius: badgeRadius,
                        ),
                      ],
                    ),
                ],
              ),
              Row(
                children: [
                  PicnicContainerIconButton(
                    iconPath: iconPathFirst,
                    onTap: onTapFirst,
                    iconTintColor: iconTintColor,
                  ),
                  if (iconPathSecond != null && onTapSecond != null)
                    Row(
                      children: [
                        const Gap(8),
                        PicnicContainerIconButton(
                          iconPath: iconPathSecond!,
                          onTap: onTapSecond,
                          iconTintColor: iconTintColor,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
