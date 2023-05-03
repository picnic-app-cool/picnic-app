import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleModBadge extends StatelessWidget {
  const CircleModBadge({super.key});

  static const _borderRadius = 6.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        gradient: PicnicColors.rainbowGradientCircleMod,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Text(
        appLocalizations.mod,
        style: theme.styles.body0.copyWith(
          color: theme.colors.blackAndWhite.shade100,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
