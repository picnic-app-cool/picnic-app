import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_centered_child_and_suffix.dart';

class PicnicBarWithAvatarTitle extends StatelessWidget implements PreferredSizeWidget {
  const PicnicBarWithAvatarTitle({
    Key? key,
    required this.iconPathLeft,
    required this.onTapLeft,
    required this.avatar,
    this.iconTintColor,
    this.suffix,
    this.backgroundColor,
  }) : super(key: key);

  final String iconPathLeft;

  final VoidCallback onTapLeft;

  final Widget avatar;

  final Widget? suffix;

  final Color? iconTintColor;

  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(PicnicBarWithCenteredChildAndSuffix.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PicnicBarWithCenteredChildAndSuffix(
      iconPathLeft: iconPathLeft,
      backgroundColor: backgroundColor,
      onTapLeft: onTapLeft,
      iconTintColor: iconTintColor,
      suffix: suffix,
      child: avatar,
    );
  }
}
