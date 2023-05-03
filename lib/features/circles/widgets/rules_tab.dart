import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/text/picnic_markdown_text.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class RulesTab extends StatelessWidget {
  const RulesTab({
    Key? key,
    required this.rules,
    required this.onTapEdit,
    required this.isMod,
  }) : super(key: key);

  final String rules;
  final VoidCallback onTapEdit;
  final bool isMod;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.rulesTabTitle, style: styles.title30),
                if (isMod)
                  PicnicTextButton(
                    label: appLocalizations.editAction,
                    onTap: onTapEdit,
                    labelStyle: theme.styles.title20.copyWith(color: theme.colors.green),
                  ),
              ],
            ),
            const Gap(8),
            PicnicMarkdownText(
              markdownSource: rules,
              textStyle: styles.body20,
            ),
          ],
        ),
      ),
    );
  }
}
