import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleAction extends StatelessWidget {
  const CircleAction({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Image icon;

  static const double _radius = 100;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final title40 = theme.styles.title40;

    final blackWithOpacity = colors.blackAndWhite.shade900.withOpacity(.07);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          color: blackWithOpacity,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: title40,
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
