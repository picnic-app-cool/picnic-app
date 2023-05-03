import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ChangeCircleAvatarButton extends StatelessWidget {
  const ChangeCircleAvatarButton({
    required this.tapAction,
    required this.text,
    required this.filled,
  });

  final VoidCallback tapAction;
  final String text;
  final bool filled;
  static const borderButtonWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final green = colors.green;
    final white = colors.blackAndWhite.shade100;
    return PicnicButton(
      borderRadius: const PicnicButtonRadius.round(),
      minWidth: double.infinity,
      title: text,
      color: filled ? green : white,
      borderColor: colors.green,
      titleColor: filled ? white : green,
      style: PicnicButtonStyle.outlined,
      borderWidth: borderButtonWidth,
      onTap: tapAction,
    );
  }
}
