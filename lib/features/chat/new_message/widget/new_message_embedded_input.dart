import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NewMessageEmbeddedInput extends StatelessWidget {
  const NewMessageEmbeddedInput({
    Key? key,
    required this.focusNode,
    required this.onChangedSearchText,
    required this.textEditingController,
    required this.showSelectedRecipients,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChangedSearchText;
  final bool showSelectedRecipients;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final textStyleBody20 = theme.styles.body20;
    final hintTextStyle = textStyleBody20.copyWith(
      color: blackAndWhite.shade600,
    );

    return TextFormField(
      focusNode: focusNode,
      onChanged: onChangedSearchText,
      controller: textEditingController,
      style: textStyleBody20,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        alignLabelWithHint: true,
        isDense: true,
        border: InputBorder.none,
        hintText: showSelectedRecipients ? '' : appLocalizations.chatNewMessageSearchInputHint,
        hintStyle: hintTextStyle,
      ),
    );
  }
}
