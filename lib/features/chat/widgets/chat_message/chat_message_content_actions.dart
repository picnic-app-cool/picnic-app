import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class ChatMessageContentActions {
  ChatMessageContentActions({
    required this.onMessageSelected,
    required this.onMessageLongPress,
    required this.onTapJoinCircle,
    required this.onTapCircleDetails,
    required this.onTapUnblurAttachment,
    required this.onTapLink,
    required this.onTapAttachment,
    required this.onDoubleTapMessage,
    required this.onTapPdf,
    required this.onTapFriendProfile,
    required this.onTapPost,
  });

  ChatMessageContentActions.empty()
      : onMessageSelected = ((_) => {}),
        onMessageLongPress = ((_) => {}),
        onTapJoinCircle = ((_) => {}),
        onTapCircleDetails = ((_) => {}),
        onTapUnblurAttachment = ((_) => {}),
        onTapLink = ((_) => {}),
        onTapAttachment = ((_) => {}),
        onDoubleTapMessage = ((_) => {}),
        onTapPdf = ((_) => {}),
        onTapFriendProfile = ((_) => {}),
        onTapPost = ((_, __) => {});

  final Function(ChatMessage) onMessageSelected;
  final OnMessageLongPress onMessageLongPress;
  final Function(ChatMessage) onTapJoinCircle;
  final Function(ChatMessage) onTapCircleDetails;
  final Function(Attachment) onTapUnblurAttachment;
  final Function(String url) onTapLink;
  final Function(ChatMessage) onTapAttachment;
  final Function(ChatMessage) onDoubleTapMessage;
  final Function(Attachment) onTapPdf;
  final Function(Id) onTapFriendProfile;
  final Function(Post, ChatMessage) onTapPost;

  ChatMessageContentActions copyWith({
    Function(ChatMessage)? onMessageSelected,
    OnMessageLongPress? onMessageLongPress,
    Function(ChatMessage)? onTapJoinCircle,
    Function(ChatMessage)? onTapCircleDetails,
    Function(Attachment)? onTapUnblurAttachment,
    Function(String url)? onTapLink,
    Function(ChatMessage)? onTapAttachment,
    Function(ChatMessage)? onDoubleTapMessage,
    Function(Attachment)? onTapPdf,
    Function(Id)? onTapFriendProfile,
    Function(Post, ChatMessage)? onTapPost,
  }) {
    return ChatMessageContentActions(
      onMessageSelected: onMessageSelected ?? this.onMessageSelected,
      onMessageLongPress: onMessageLongPress ?? this.onMessageLongPress,
      onTapJoinCircle: onTapJoinCircle ?? this.onTapJoinCircle,
      onTapCircleDetails: onTapCircleDetails ?? this.onTapCircleDetails,
      onTapUnblurAttachment: onTapUnblurAttachment ?? this.onTapUnblurAttachment,
      onTapLink: onTapLink ?? this.onTapLink,
      onTapAttachment: onTapAttachment ?? this.onTapAttachment,
      onDoubleTapMessage: onDoubleTapMessage ?? this.onDoubleTapMessage,
      onTapPdf: onTapPdf ?? this.onTapPdf,
      onTapFriendProfile: onTapFriendProfile ?? this.onTapFriendProfile,
      onTapPost: onTapPost ?? this.onTapPost,
    );
  }
}
