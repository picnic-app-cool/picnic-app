import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({
    required this.iconPath,
    required this.text,
    required this.iconSize,
  });

  final String iconPath;
  final String text;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: PicnicColors.paleGrey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
            ),
            const Gap(20),
            Text(
              text,
              style: theme.styles.body30.copyWith(
                color: theme.colors.blackAndWhite.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
