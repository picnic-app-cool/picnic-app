import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';

typedef OnMessageLongPress = Function(MessageActionsOpenEvent);

class MessageActionsOpenEvent extends Equatable {
  const MessageActionsOpenEvent({
    required this.sourceLeft,
    required this.sourceTop,
    this.sourceWidth = 0,
    this.sourceHeight = 0,
    required this.displayableMessage,
  });

  const MessageActionsOpenEvent.empty()
      : sourceLeft = 0,
        sourceTop = 0,
        sourceWidth = 0,
        sourceHeight = 0,
        displayableMessage = const DisplayableChatMessage.empty();

  final double sourceLeft;
  final double sourceTop;
  final double sourceWidth;
  final double sourceHeight;
  final DisplayableChatMessage displayableMessage;

  @override
  List<Object> get props => [
        sourceLeft,
        sourceTop,
        sourceWidth,
        sourceHeight,
        displayableMessage,
      ];

  MessageActionsOpenEvent copyWith({
    double? sourceLeft,
    double? sourceTop,
    double? sourceWidth,
    double? sourceHeight,
    DisplayableChatMessage? displayableMessage,
  }) {
    return MessageActionsOpenEvent(
      sourceLeft: sourceLeft ?? this.sourceLeft,
      sourceTop: sourceTop ?? this.sourceTop,
      sourceWidth: sourceWidth ?? this.sourceWidth,
      sourceHeight: sourceHeight ?? this.sourceHeight,
      displayableMessage: displayableMessage ?? this.displayableMessage,
    );
  }
}
