import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

mixin RulesBottomSheetRoute {
  void openRulesBottomSheet({required VoidCallback onTapClose}) => showPicnicBottomSheet(
        RulesBottomSheet(
          onTapClose: onTapClose,
        ),
      );
}

class RulesBottomSheet extends StatelessWidget {
  const RulesBottomSheet({
    Key? key,
    required this.onTapClose,
  }) : super(key: key);

  final VoidCallback onTapClose;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final body20 = theme.styles.body20;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.directorRulesTitle,
              style: styles.title30,
            ),
            const Gap(20),
            Text(
              appLocalizations.modRulesDescription,
              style: body20,
            ),
            const Gap(20),
            Text(
              appLocalizations.modRuleOne,
              style: body20,
            ),
            Text(
              appLocalizations.modRuleTwo,
              style: body20,
            ),
            Text(
              appLocalizations.modRuleThree,
              style: body20,
            ),
            Text(
              appLocalizations.modRuleFour,
              style: body20,
            ),
            Text(
              appLocalizations.modRuleFive,
              style: body20,
            ),
            Text(
              appLocalizations.modRuleSix,
              style: body20,
            ),
            const Gap(20),
            Text(
              appLocalizations.modRulesThankYouNote,
              style: body20,
            ),
            const Gap(12),
            Center(
              child: PicnicTextButton(
                label: appLocalizations.closeAction,
                onTap: onTapClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
