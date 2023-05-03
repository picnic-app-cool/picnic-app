import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/model/delete_multiple_messages_condition.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DeleteMultipleMessagesConditionsListItem extends StatelessWidget {
  const DeleteMultipleMessagesConditionsListItem({
    required this.condition,
    required this.onTapItem,
    super.key,
  });

  final DeleteMultipleMessagesCondition condition;
  final ValueChanged<DeleteMultipleMessagesCondition> onTapItem;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTapItem(condition),
      child: Text(
        condition.valueToDisplay,
        style: styles.body30,
      ),
    );
  }
}
