import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ProfileHorizontalItem extends StatelessWidget {
  const ProfileHorizontalItem({
    Key? key,
    required this.onTap,
    required this.title,
    this.titleStyle,
    this.trailing,
    this.leading,
    this.onTapTrailing,
  }) : super(key: key);

  final VoidCallback? onTap;
  final VoidCallback? onTapTrailing;

  final Widget? trailing;
  final String title;
  final TextStyle? titleStyle;

  final Widget? leading;

  static const double _itemHeight = 48;
  static const double _itemRadius = 100;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return PicnicListItem(
      title: title,
      titleStyle: titleStyle ?? styles.link15.copyWith(color: colors.darkBlue.shade800),
      onTapDetails: onTapTrailing,
      onTap: onTap,
      height: _itemHeight,
      trailing: trailing,
      fillColor: colors.darkBlue.shade300,
      borderRadius: _itemRadius,
      leading: leading,
    );
  }
}
