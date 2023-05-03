import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';

class MessageActionsInitialParams {
  const MessageActionsInitialParams({
    required this.event,
    required this.popupMenuItems,
  });

  final MessageActionsOpenEvent event;
  final List<PopUpMenuItem> popupMenuItems;
}
