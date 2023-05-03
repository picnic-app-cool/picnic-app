import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessageReactionsPanel extends StatelessWidget {
  const ChatMessageReactionsPanel({
    super.key,
    required this.reactions,
    required this.isUserMessage,
  });

  final List<ChatMessageReaction> reactions;
  final bool isUserMessage;

  static const double _borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final white = colors.blackAndWhite.shade100;
    final white15 = white.withOpacity(0.15);
    final black = colors.blackAndWhite.shade900;
    final green = colors.green.shade500;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: reactions.where((r) => r.count > 0).map((r) {
        final boxColor = isUserMessage
            ? (r.hasReacted ? white : white15)
            : r.hasReacted
                ? green
                : white;

        final textColor = isUserMessage
            ? (r.hasReacted ? black : white)
            : r.hasReacted
                ? white
                : black;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: boxColor,
          ),
          child: Row(
            children: [
              Text(r.reactionType.value),
              const Gap(2),
              Text(
                '${r.count}',
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
