//ignore_for_file: unused-code, unused-files
import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// a draft chat message created by user used to be sent to backend
class ChatMessageReactionInput extends Equatable {
  const ChatMessageReactionInput({
    required this.id,
    required this.hasReacted,
  });

  const ChatMessageReactionInput.empty()
      : id = const Id.empty(),
        hasReacted = false;

  final Id id;
  final bool hasReacted;

  @override
  List<Object> get props => [
        id,
        hasReacted,
      ];

  ChatMessageReactionInput copyWith({
    Id? id,
    bool? hasReacted,
  }) {
    return ChatMessageReactionInput(
      id: id ?? this.id,
      hasReacted: hasReacted ?? this.hasReacted,
    );
  }
}
