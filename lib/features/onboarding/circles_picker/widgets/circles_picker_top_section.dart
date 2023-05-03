import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CirclesPickerTopSection extends StatelessWidget {
  const CirclesPickerTopSection({
    super.key,
    required this.anythingSelected,
    required this.selectionsLeftCount,
  });

  final bool anythingSelected;
  final int selectionsLeftCount;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            appLocalizations.circlesGroupingsDescription,
            textAlign: TextAlign.center,
            style: theme.styles.body10.copyWith(color: blackAndWhite.shade600),
          ),
        ),
        const Gap(12),
        if (selectionsLeftCount > 0) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              anythingSelected
                  ? appLocalizations.circlesGroupingsSelectMoreCirclesHint(selectionsLeftCount)
                  : appLocalizations.circlesGroupingsSelectCirclesHint(selectionsLeftCount),
              textAlign: TextAlign.center,
              style: theme.styles.body30.copyWith(color: blackAndWhite.shade500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: blackAndWhite.shade500,
            ),
          ),
        ],
      ],
    );
  }
}
