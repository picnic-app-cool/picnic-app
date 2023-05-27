import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NewMessageGroupInput extends StatelessWidget {
  const NewMessageGroupInput({
    Key? key,
    required this.textEditingController,
    required this.onChangedUpdateGroupName,
    required this.focusNode,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final ValueChanged<String>? onChangedUpdateGroupName;
  final FocusNode focusNode;
  static const _inputPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    bottom: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final textStyleBody20 = theme.styles.body20;
    final blue = colors.blue;
    final userTyping = focusNode.hasPrimaryFocus && textEditingController.text.isNotEmpty;

    return Padding(
      padding: _inputPadding,
      child: PicnicTextInput(
        focusNode: focusNode,
        onChanged: onChangedUpdateGroupName,
        inputFillColor: userTyping ? blackAndWhite.shade100 : blackAndWhite.shade200,
        focusedBorderSide: BorderSide(color: blue),
        hintText: appLocalizations.chatNewMessageSearchInputHintGroup,
        inputTextStyle: textStyleBody20,
        textController: textEditingController,
      ),
    );
  }
}
