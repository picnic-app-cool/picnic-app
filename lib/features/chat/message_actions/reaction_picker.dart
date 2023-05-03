import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: no-magic-number
class ReactionPicker extends StatelessWidget {
  const ReactionPicker({
    super.key,
    required this.onReactionPressed,
    required this.selectedReactions,
  });

  final List<ChatMessageReaction> selectedReactions;

  final ValueChanged<ChatMessageReactionType> onReactionPressed;

  static const double _emojiSize = 26;
  static const double _verticalPadding = 10;
  static const double _horizontalPadding = 12;
  static const double _selectedOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    final white = PicnicTheme.of(context).colors.blackAndWhite.shade100;
    final reactionTypes = ChatMessageReactionType.values;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_emojiSize),
        color: white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reactionTypes.mapIndexed(
          (index, reactionType) {
            final isSelected = selectedReactions.map((s) => s.reactionType).contains(reactionType);
            return InkWell(
              onTap: () => onReactionPressed(reactionType),
              child: Padding(
                padding: EdgeInsets.only(
                  top: _verticalPadding,
                  bottom: _verticalPadding,
                  left: index == 0 ? _horizontalPadding : _horizontalPadding / 2,
                  right: index == reactionTypes.length - 1 ? _horizontalPadding : _horizontalPadding / 2,
                ),
                child: Opacity(
                  opacity: isSelected ? _selectedOpacity : 1,
                  child: Text(
                    reactionType.value,
                    style: const TextStyle(
                      fontSize: _emojiSize,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
