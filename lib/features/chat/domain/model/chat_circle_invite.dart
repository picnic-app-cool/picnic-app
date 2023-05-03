import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatCircleInvite extends Equatable implements ChatSpecialMessage {
  const ChatCircleInvite({
    required this.circleId,
    required this.circle,
    required this.userId,
  });

  const ChatCircleInvite.empty()
      : circleId = const Id.empty(),
        circle = const BasicCircle.empty(),
        userId = const Id.empty();

  final Id circleId;
  final BasicCircle circle;
  final Id userId;

  @override
  ChatComponentType get type => ChatComponentType.circleInvite;

  @override
  List<Object?> get props => [
        circleId,
        circle,
        userId,
      ];

  ChatCircleInvite copyWith({
    Id? circleId,
    BasicCircle? circle,
    Id? userId,
  }) {
    return ChatCircleInvite(
      circleId: circleId ?? this.circleId,
      circle: circle ?? this.circle,
      userId: userId ?? this.userId,
    );
  }
}
