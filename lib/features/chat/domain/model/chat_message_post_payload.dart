import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class ChatMessagePostPayload extends Equatable implements ChatSpecialMessage {
  const ChatMessagePostPayload({
    required this.postId,
    required this.post,
  });

  const ChatMessagePostPayload.empty()
      : postId = const Id.empty(),
        post = const Post.empty();

  final Id postId;
  final Post post;

  @override
  ChatComponentType get type => ChatComponentType.post;

  @override
  List<Object?> get props => [
        postId,
        post,
      ];

  ChatMessagePostPayload copyWith({
    Id? postId,
    Post? post,
  }) {
    return ChatMessagePostPayload(
      postId: postId ?? this.postId,
      post: post ?? this.post,
    );
  }
}
