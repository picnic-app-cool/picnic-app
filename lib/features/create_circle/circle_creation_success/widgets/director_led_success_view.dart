import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DirectorLedSuccessView extends StatelessWidget {
  const DirectorLedSuccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final textStyle = theme.styles.caption20.copyWith(
      color: blackAndWhite.shade600,
      fontWeight: FontWeight.normal,
    );

    final starPath = Assets.images.star.path;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(starPath),
            const Gap(12),
            Expanded(
              child: Text(
                appLocalizations.directorLedSuccessLabelOne,
                style: textStyle,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Image.asset(starPath),
            const Gap(12),
            Expanded(
              child: Text(
                appLocalizations.directorLedSuccessLabelTwo,
                style: textStyle,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Image.asset(starPath),
            const Gap(12),
            Expanded(
              child: Text(
                appLocalizations.directorLedSuccessLabelThree,
                style: textStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
