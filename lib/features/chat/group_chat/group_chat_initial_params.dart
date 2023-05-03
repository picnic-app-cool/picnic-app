import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';

class GroupChatInitialParams {
  const GroupChatInitialParams.fromNewMessage({
    required this.chat,
    required this.chatMessage,
  });

  GroupChatInitialParams.fromExistingChat({
    required this.chat,
  }) : chatMessage = const ChatMessage.empty();

  final ChatMessage chatMessage;
  final BasicChat chat;

  MediaPickerInitialParams toMediaPickerInitialParams() => const MediaPickerInitialParams();
}
