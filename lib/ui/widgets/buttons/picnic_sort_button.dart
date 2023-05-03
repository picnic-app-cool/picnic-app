import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicSortButton extends StatelessWidget {
  const PicnicSortButton({
    required this.label,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  static const double _borderRadius = 12;
  static const double _selectedColorOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius),
                color: colors.green.withOpacity(
                  _selectedColorOpacity,
                ),
              )
            : null,
        child: Text(
          label,
          style: styles.body30,
        ),
      ),
    );
  }
}
