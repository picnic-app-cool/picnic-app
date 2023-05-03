import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/model/delete_multiple_messages_condition.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DeleteMultipleMessagesConditionInput extends StatelessWidget {
  const DeleteMultipleMessagesConditionInput({
    required this.selectedCondition,
    required this.onTapInput,
  });

  final DeleteMultipleMessagesCondition selectedCondition;
  final VoidCallback onTapInput;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody20 = theme.styles.body20;
    final downArrowIcon = Image.asset(Assets.images.arrowDown.path);

    return PicnicTextInput(
      //The form field will change every time the Key changes.
      key: Key(selectedCondition.name),
      readOnly: true,
      initialValue: selectedCondition.valueToDisplay,
      suffix: InkWell(
        onTap: onTapInput,
        child: downArrowIcon,
      ),
      inputTextStyle: textStyleBody20,
      padding: 0,
    );
  }
}
