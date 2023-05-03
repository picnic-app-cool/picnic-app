import 'package:picnic_app/core/domain/model/entity_type.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlNotifyMetaInput {
  GqlNotifyMetaInput({
    required this.entityType,
    required this.postId,
    required this.chatId,
    required this.commentId,
  });

  final EntityType entityType;
  final Id postId;
  final Id chatId;
  final Id commentId;

  Map<String, dynamic> toJson() {
    return {
      'entityType': entityType.value,
      if (postId.value.isNotEmpty) 'postID': postId.value,
      if (chatId.value.isNotEmpty) 'chatID': chatId.value,
      if (commentId.value.isNotEmpty) 'commentID': commentId.value,
    };
  }
}

extension GqlMetaInputMapper on NotifyMeta {
  GqlNotifyMetaInput toGqlMetaInput() => GqlNotifyMetaInput(
        entityType: entityType,
        postId: postId,
        chatId: chatId,
        commentId: commentId,
      );
}
