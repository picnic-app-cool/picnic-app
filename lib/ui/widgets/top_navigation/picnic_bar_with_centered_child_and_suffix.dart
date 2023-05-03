import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';

class PicnicBarWithCenteredChildAndSuffix extends StatelessWidget implements PreferredSizeWidget {
  const PicnicBarWithCenteredChildAndSuffix({
    Key? key,
    required this.child,
    required this.iconPathLeft,
    required this.onTapLeft,
    this.suffix,
    this.padding,
    this.iconTintColor,
    this.backgroundColor,
  }) : super(key: key);

  final String iconPathLeft;

  final Widget? suffix;
  final Widget child;

  final VoidCallback onTapLeft;

  final EdgeInsets? padding;

  final Color? iconTintColor;
  final Color? backgroundColor;

  static const double toolbarHeight = 88;

  ///Left padding to keep the title on the center when
  ///[PicnicBarWithCenteredChildAndSuffix.iconPathLeft] is being shown
  static const appBarLeftPadding = 24.0;

  @override
  Size get preferredSize => const Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        toolbarHeight + MediaQuery.of(context).padding.top,
      ),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: backgroundColor ?? Colors.transparent,
              padding: padding ??
                  const EdgeInsets.symmetric(
                    horizontal: Constants.largePadding,
                    vertical: Constants.mediumPadding,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PicnicContainerIconButton(
                    iconPath: iconPathLeft,
                    onTap: onTapLeft,
                    iconTintColor: iconTintColor,
                  ),
                  child,
                  if (suffix != null) suffix!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
