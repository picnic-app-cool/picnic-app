import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicReportReasonDescriptionInput extends StatelessWidget {
  const PicnicReportReasonDescriptionInput({
    Key? key,
    required this.onChangedDescription,
  }) : super(key: key);

  final ValueChanged<String> onChangedDescription;
  static const _textFieldReportDescriptionMaxLines = 6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody20 = theme.styles.body20;

    return PicnicTextInput(
      onChanged: onChangedDescription,
      hintText: appLocalizations.reportFormInputBodyLabel,
      maxLines: _textFieldReportDescriptionMaxLines,
      inputTextStyle: textStyleBody20,
    );
  }
}
