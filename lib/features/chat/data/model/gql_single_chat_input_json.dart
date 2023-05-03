import 'package:picnic_app/features/chat/domain/model/single_chat_input.dart';

extension GqlSingleChatInputJson on SingleChatInput {
  Map<String, dynamic> toJson() {
    return {
      'userIds': userIds.map((it) => it.value).toList(),
    };
  }
}
