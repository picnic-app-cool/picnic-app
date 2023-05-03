import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';

class GroupChatMoreInitialParams {
  const GroupChatMoreInitialParams({
    required this.chat,
    this.onChatChanged,
  });

  final BasicChat chat;
  final ValueChanged<BasicChat>? onChatChanged;
}
