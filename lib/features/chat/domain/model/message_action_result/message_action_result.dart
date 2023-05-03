import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';

abstract class MessageActionResult {
  MessageActionResultType get type;
}

extension MessageActionResultSwitch on MessageActionResult {
  void when({
    Function(PopUpMenuItem item)? popUpMenuItemAction,
    Function(ChatMessageReactionType reaction)? chatMessageReactionAction,
  }) {
    switch (type) {
      case MessageActionResultType.popUpMenuItem:
        popUpMenuItemAction?.call(this as PopUpMenuItem);
        break;
      case MessageActionResultType.chatMessageReaction:
        chatMessageReactionAction?.call(this as ChatMessageReactionType);
        break;
    }
  }
}

enum MessageActionResultType { popUpMenuItem, chatMessageReaction }
