import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PicnicAppBar({
    this.iconPathLeft,
    this.child,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.showBackButton,
    this.systemOverlayStyle,
    this.backButtonColor,
    this.backButtonIconColor,
    this.backButtonBackdropFilter,
    this.height = Constants.toolbarHeight,
    this.onTapBack,
    this.titleSpacing,
    this.titleText,
  }) : assert(child == null || titleText == null, "You can't use both child and titleText at the same time");

  final String? iconPathLeft;
  final Widget? child;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool? showBackButton;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? backButtonColor;
  final Color? backButtonIconColor;
  final ImageFilter? backButtonBackdropFilter;
  final double height;
  final VoidCallback? onTapBack;
  final double? titleSpacing;
  final String? titleText;

  static const double _leadingWidth = 72.0;
  static const _contentHeight = Constants.toolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Let's show the back button for unit tests always, unless it was
      // explicitly hidden with `showBackButton = false`
      // This will be helpful to see back buttons in tests, since in tests we have no navigator plugged in
      leading: showBackButton ?? (isUnitTests || Navigator.of(context).canPop())
          ? Padding(
              padding: const EdgeInsets.only(
                left: Constants.defaultPadding,
                top: Constants.smallPadding,
                bottom: Constants.smallPadding,
                right: Constants.smallPadding,
              ),
              child: PicnicContainerIconButton(
                buttonColor: backButtonColor ?? Colors.transparent,
                iconTintColor: backButtonIconColor,
                backdropFilter: backButtonBackdropFilter,
                iconPath: _iconPath(iconPathLeft),
                onTap: onTapBack ?? () => Navigator.of(context).pop(),
                padding: 0,
              ),
            )
          : null,
      automaticallyImplyLeading: false,
      title: titleText != null
          ? Text(
              titleText!,
              style: PicnicTheme.of(context).styles.subtitle30,
            )
          : child,
      titleSpacing: titleSpacing,
      systemOverlayStyle: systemOverlayStyle,
      actions: [
        ...(actions ?? [])
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(
                  left: Constants.defaultPadding,
                  top: Constants.smallPadding,
                  bottom: Constants.smallPadding,
                ),
                child: e,
              ),
            )
            .toList(),
        const Gap(16.0),
      ],
      shadowColor: Colors.transparent,
      backgroundColor: backgroundColor,
      centerTitle: true,
      leadingWidth: _leadingWidth,
      toolbarHeight: _contentHeight,
      elevation: 0,
    );
  }

  static String _iconPath(String? iconPathLeft) => iconPathLeft ?? Assets.images.backArrow.path;
}
