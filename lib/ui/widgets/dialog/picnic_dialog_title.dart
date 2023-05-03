import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicDialogTitle extends StatelessWidget {
  const PicnicDialogTitle({
    Key? key,
    required this.text,
    this.size = PicnicDialogTitleSize.normal,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final PicnicDialogTitleSize size;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Text(
      text,
      style: size == PicnicDialogTitleSize.custom
          ? textStyle
          : size == PicnicDialogTitleSize.normal
              ? theme.styles.title30
              : theme.styles.display20,
    );
  }
}

enum PicnicDialogTitleSize { normal, large, custom }
