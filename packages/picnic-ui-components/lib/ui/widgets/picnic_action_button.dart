import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicActionButton extends StatelessWidget {
  const PicnicActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Image icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final textStyle = theme.styles.subtitle15.copyWith(
      color: theme.colors.blue.shade800,
    );
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          icon,
          const Gap(8),
          Text(
            label,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
