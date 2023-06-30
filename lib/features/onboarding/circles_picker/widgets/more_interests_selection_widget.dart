import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/onboarding/circles_picker/widgets/interests_selection_section.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MoreInterestsSelectionWidget extends StatelessWidget {
  const MoreInterestsSelectionWidget({
    required this.selectableInterests,
    required this.onTapInterest,
    required this.onTapMore,
    required this.isExpanded,
  });

  final List<Selectable<Interest>> selectableInterests;
  final void Function(Selectable<Interest> circle) onTapInterest;
  final void Function() onTapMore;
  final bool isExpanded;
  static const _arrowSize = 14.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTapMore,
          child: Row(
            children: [
              Text(
                appLocalizations.moreLabel,
                style: styles.body15.copyWith(
                  color: darkBlue.shade700,
                ),
              ),
              const Gap(4),
              Icon(
                isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                color: darkBlue.shade600,
                size: _arrowSize,
              ),
            ],
          ),
        ),
        const Gap(8),
        if (isExpanded)
          InterestsSelectionSection(
            selectableInterests: selectableInterests,
            onTapInterest: onTapInterest,
          ),
      ],
    );
  }
}
