//ignore_for_file: unused-code, unused-files
import 'package:equatable/equatable.dart';

class ChatSettings extends Equatable {
  const ChatSettings({
    required this.isMuted,
  });

  const ChatSettings.empty() : isMuted = false;

  final bool isMuted;

  @override
  List<Object> get props => [
        isMuted,
      ];

  ChatSettings copyWith({
    bool? isMuted,
  }) {
    return ChatSettings(
      isMuted: isMuted ?? this.isMuted,
    );
  }
}
