import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicSubtitle extends StatelessWidget {
  const PicnicSubtitle({
    Key? key,
    this.subtitle,
    this.subtitleStyle,
  }) : super(key: key);

  final String? subtitle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Text(
      subtitle ?? '',
      style: subtitleStyle ??
          theme.styles.caption10.copyWith(
            color: theme.colors.blackAndWhite.shade600,
          ),
    );
  }
}
