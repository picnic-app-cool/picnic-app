import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/model/delete_multiple_messages_condition.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/widgets/delete_multiple_messages_conditions_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DeleteMultipleMessagesConditionsList extends StatelessWidget {
  const DeleteMultipleMessagesConditionsList({
    required this.conditions,
    required this.onTapItem,
    super.key,
  });

  final List<DeleteMultipleMessagesCondition> conditions;
  final ValueChanged<DeleteMultipleMessagesCondition> onTapItem;

  static const _borderRadius = 16.0;
  static const _blurRadius = 30.0;
  static const _shadowOpacity = 0.07;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_borderRadius);
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.blackAndWhite.shade100,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: _blurRadius,
            color: colors.blackAndWhite.shade900.withOpacity(_shadowOpacity),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = DeleteMultipleMessagesConditionsListItem(
              condition: conditions[index],
              onTapItem: onTapItem,
            );

            if (index == conditions.length - 1) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: colors.blackAndWhite.shade300,
                  ),
                  const Gap(12),
                  item,
                ],
              );
            }

            return item;
          },
          separatorBuilder: (context, index) => const Gap(20),
          itemCount: conditions.length,
        ),
      ),
    );
  }
}
