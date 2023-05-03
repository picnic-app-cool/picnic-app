import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/entity_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class NotifyMeta extends Equatable {
  const NotifyMeta({
    required this.entityType,
    required this.postId,
    required this.chatId,
    required this.commentId,
  });

  const NotifyMeta.empty() : this.post();

  const NotifyMeta.post()
      : entityType = EntityType.post,
        postId = const Id.none(),
        chatId = const Id.none(),
        commentId = const Id.none();

  const NotifyMeta.chat()
      : entityType = EntityType.chat,
        postId = const Id.none(),
        chatId = const Id.none(),
        commentId = const Id.none();

  const NotifyMeta.comment()
      : entityType = EntityType.chat,
        postId = const Id.none(),
        chatId = const Id.none(),
        commentId = const Id.none();

  final EntityType entityType;
  final Id postId;
  final Id chatId;
  final Id commentId;

  @override
  List<Object?> get props => [
        entityType,
        postId,
        chatId,
        commentId,
      ];

  NotifyMeta copyWith({
    EntityType? entityType,
    Id? postId,
    Id? chatId,
    Id? commentId,
  }) {
    return NotifyMeta(
      entityType: entityType ?? this.entityType,
      postId: postId ?? this.postId,
      chatId: chatId ?? this.chatId,
      commentId: commentId ?? this.commentId,
    );
  }
}
