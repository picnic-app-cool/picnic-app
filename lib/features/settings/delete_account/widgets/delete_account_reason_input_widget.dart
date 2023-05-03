import 'package:flutter/material.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DeleteAccountReasonInputWidget extends StatelessWidget {
  const DeleteAccountReasonInputWidget({
    required this.onTapDisplayReasons,
    this.reasonTitle,
    this.hintText,
    this.onChangedReason,
  });

  final VoidCallback onTapDisplayReasons;
  final String? reasonTitle;
  final String? hintText;
  final ValueChanged<DeleteAccountReason>? onChangedReason;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody20 = theme.styles.body20;
    final _downArrowIcon = Image.asset(Assets.images.arrowDown.path);

    return PicnicTextInput(
      //The form field will change every time the Key changes.
      key: Key(reasonTitle ?? (hintText ?? "")),
      readOnly: true,
      hintText: hintText ?? "",
      initialValue: reasonTitle,
      outerLabel: Text(
        appLocalizations.reportFormInputSelectLabel,
        style: textStyleBody20,
      ),
      suffix: InkWell(
        onTap: onTapDisplayReasons,
        child: _downArrowIcon,
      ),
      inputTextStyle: textStyleBody20,
    );
  }
}
