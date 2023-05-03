import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DisabledCommentsView extends StatelessWidget {
  const DisabledCommentsView({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  static const _borderRadius = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: blackAndWhite.shade300,
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            child: Text(
              text,
              style: theme.styles.body10.copyWith(
                color: blackAndWhite.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
