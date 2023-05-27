import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_radio_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RuleDecisionView extends StatelessWidget {
  const RuleDecisionView({
    Key? key,
    required this.rules,
    required this.selectedRule,
    required this.onDecisionChanged,
  }) : super(key: key);

  final List<CircleModerationType> rules;
  final CircleModerationType selectedRule;
  final Function(CircleModerationType) onDecisionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return ListView(
      children: [
        Text(
          appLocalizations.ruleSelectionTitle,
          style: theme.styles.subtitle40,
        ),
        const Gap(20),
        ...rules
            .map(
              (it) => PicnicRadioButton<CircleModerationType>(
                value: it,
                groupValue: selectedRule,
                label: it.label,
                onChanged: (type) => onDecisionChanged(type ?? CircleModerationType.director),
              ),
            )
            .toList(),
        const Gap(20),
        Text(
          appLocalizations.ruleSelectionNote,
          style: theme.styles.caption20.copyWith(color: blackAndWhite.shade600),
        ),
      ],
    );
  }
}
