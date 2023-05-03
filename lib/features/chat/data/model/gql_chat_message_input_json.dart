import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';

extension GqlChatMessageInputJson on ChatMessageInput {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'type': type.stringVal,
      'repliedToMessageId': repliedToMessageId.isNone ? null : repliedToMessageId.value,
      if (attachmentIds.isNotEmpty) 'attachmentIds': attachmentIds.map((id) => id.value).toList(),
    };
  }
}
