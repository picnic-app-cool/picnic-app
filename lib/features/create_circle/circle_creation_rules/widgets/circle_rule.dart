import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleRule extends StatelessWidget {
  const CircleRule({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.styles.subtitle40,
        ),
        const Gap(8),
        Text(
          description,
          style: theme.styles.subtitle20.copyWith(
            color: blackAndWhite.shade500,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
