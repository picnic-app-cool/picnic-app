import 'package:picnic_app/features/chat/domain/model/group_chat_input.dart';

extension GqlGroupChatInputJson on GroupChatInput {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userIds': userIds.map((it) => it.value).toList(),
    };
  }
}
