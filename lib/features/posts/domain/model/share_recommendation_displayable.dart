import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';

class ShareRecommendationDisplayable extends Equatable {
  const ShareRecommendationDisplayable({
    required this.chatDisplayable,
    required this.isSent,
  });

  const ShareRecommendationDisplayable.empty()
      : chatDisplayable = const ChatListItemDisplayable.empty(),
        isSent = false;

  final ChatListItemDisplayable chatDisplayable;
  final bool isSent;

  @override
  List<Object?> get props => [
        chatDisplayable,
        isSent,
      ];

  ShareRecommendationDisplayable copyWith({
    ChatListItemDisplayable? chatDisplayable,
    bool? isSent,
  }) {
    return ShareRecommendationDisplayable(
      chatDisplayable: chatDisplayable ?? this.chatDisplayable,
      isSent: isSent ?? this.isSent,
    );
  }
}
