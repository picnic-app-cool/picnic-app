import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DiscordExplanation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    const discordImageHeight = 28.0;
    const discordImageWidth = 22.0;
    return Container(
      decoration: const BoxDecoration(
        color: PicnicColors.paleGrey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.images.discord.path,
              height: discordImageHeight,
              width: discordImageWidth,
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.discordIntegrationTitle,
                    style: theme.styles.body30.copyWith(
                      color: blackAndWhite.shade800,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    appLocalizations.discordIntegrationDescription,
                    style: theme.styles.caption20.copyWith(color: blackAndWhite.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
