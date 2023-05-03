import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class HowToGetSeeds extends StatelessWidget {
  const HowToGetSeeds({
    required this.iconPath,
    required this.text,
  });

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    const iconSize = 32.0;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PicnicColors.lightGrey),
        color: blackAndWhite.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
            ),
            const Gap(10),
            Expanded(
              child: Text(
                text,
                style: theme.styles.body20.copyWith(
                  color: blackAndWhite.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
