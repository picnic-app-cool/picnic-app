import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicVerticalTextPost extends StatelessWidget {
  const PicnicVerticalTextPost({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  static const _maxLines = 6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: _maxLines,
      style: theme.styles.body30.copyWith(
        color: theme.colors.blackAndWhite.shade100,
      ),
    );
  }
}
