import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class TextPostPreview extends StatelessWidget {
  const TextPostPreview({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final body30 = theme.styles.body30.copyWith(color: theme.colors.blackAndWhite.shade900);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        text,
        style: body30,
      ),
    );
  }
}
