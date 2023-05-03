import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';

//ignore_for_file: unused-code, unused-files
class UnknownChatEvent extends Equatable implements ChatEvent {
  const UnknownChatEvent({
    required this.payload,
  });

  const UnknownChatEvent.empty() : payload = '';

  final String payload;

  @override
  List<Object?> get props => [
        payload,
      ];

  @override
  ChatEventType get type => ChatEventType.unknown;

  UnknownChatEvent copyWith({
    String? payload,
  }) {
    return UnknownChatEvent(
      payload: payload ?? this.payload,
    );
  }
}
