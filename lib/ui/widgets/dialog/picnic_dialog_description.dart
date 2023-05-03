import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicDialogDescription extends StatelessWidget {
  const PicnicDialogDescription({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Text(
      text,
      textAlign: TextAlign.center,
      style: textStyle ??
          theme.styles.body30.copyWith(
            color: theme.colors.blackAndWhite.shade600,
          ),
    );
  }
}
