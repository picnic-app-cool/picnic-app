import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RuleInput extends StatelessWidget {
  const RuleInput({
    Key? key,
    required this.onChangedRule,
    required this.rules,
  }) : super(key: key);

  final ValueChanged<String> onChangedRule;
  final String rules;
  static const _textFieldReportDescriptionMaxLines = 6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody20 = theme.styles.body20;

    return PicnicTextInput(
      initialValue: rules,
      onChanged: onChangedRule,
      hintText: appLocalizations.editRulesHint,
      maxLines: _textFieldReportDescriptionMaxLines,
      inputTextStyle: textStyleBody20,
    );
  }
}
