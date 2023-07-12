//ignore_for_file: too_many_public_members
import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatMessageComponentInput extends Equatable {
  const ChatMessageComponentInput({
    required this.type,
    required this.circleInvite,
    required this.seedsExchange,
    required this.glitterBomb,
    required this.entity,
  });

  const ChatMessageComponentInput.empty()
      : type = ChatComponentType.unknown,
        circleInvite = const ChatMessageCircleInviteInput.empty(),
        seedsExchange = const ChatMessageSeedsExchangeInput.empty(),
        glitterBomb = const ChatMessageGlitterBombInput.empty(),
        entity = const ChatMessageEntityInput.empty();

  final ChatComponentType type;
  final ChatMessageCircleInviteInput circleInvite;
  final ChatMessageSeedsExchangeInput seedsExchange;
  final ChatMessageGlitterBombInput glitterBomb;
  final ChatMessageEntityInput entity;

  @override
  List<Object> get props => [
        type,
        circleInvite,
        seedsExchange,
        glitterBomb,
        entity,
      ];

  ChatMessageComponentInput copyWith({
    ChatComponentType? type,
    ChatMessageCircleInviteInput? circleInvite,
    ChatMessageSeedsExchangeInput? seedsExchange,
    ChatMessageGlitterBombInput? glitterBomb,
    ChatMessageEntityInput? entity,
  }) {
    return ChatMessageComponentInput(
      type: type ?? this.type,
      circleInvite: circleInvite ?? this.circleInvite,
      seedsExchange: seedsExchange ?? this.seedsExchange,
      glitterBomb: glitterBomb ?? this.glitterBomb,
      entity: entity ?? this.entity,
    );
  }
}

class ChatMessageCircleInviteInput extends Equatable {
  const ChatMessageCircleInviteInput({
    required this.circleId,
    required this.userId,
  });

  const ChatMessageCircleInviteInput.empty()
      : circleId = const Id.none(),
        userId = const Id.none();

  final Id circleId;
  final Id userId;

  @override
  List<Object> get props => [
        circleId,
        userId,
      ];

  ChatMessageCircleInviteInput copyWith({
    Id? circleId,
    Id? userId,
  }) {
    return ChatMessageCircleInviteInput(
      circleId: circleId ?? this.circleId,
      userId: userId ?? this.userId,
    );
  }
}

class ChatMessageSeedsExchangeInput extends Equatable {
  const ChatMessageSeedsExchangeInput({
    required this.offerId,
    required this.userId,
  });

  const ChatMessageSeedsExchangeInput.empty()
      : offerId = const Id.none(),
        userId = const Id.none();

  final Id offerId;
  final Id userId;

  @override
  List<Object> get props => [
        offerId,
        userId,
      ];

  ChatMessageSeedsExchangeInput copyWith({
    Id? offerId,
    Id? userId,
  }) {
    return ChatMessageSeedsExchangeInput(
      offerId: offerId ?? this.offerId,
      userId: userId ?? this.userId,
    );
  }
}

class ChatMessageGlitterBombInput extends Equatable {
  const ChatMessageGlitterBombInput({
    required this.senderId,
  });

  const ChatMessageGlitterBombInput.empty() : senderId = const Id.none();

  final Id senderId;

  @override
  List<Object> get props => [
        senderId,
      ];

  ChatMessageGlitterBombInput copyWith({
    Id? senderId,
  }) {
    return ChatMessageGlitterBombInput(
      senderId: senderId ?? this.senderId,
    );
  }
}

class ChatMessageEntityInput extends Equatable {
  const ChatMessageEntityInput({
    required this.entityId,
  });

  const ChatMessageEntityInput.empty() : entityId = const Id.none();

  final Id entityId;

  @override
  List<Object> get props => [
        entityId,
      ];

  ChatMessageEntityInput copyWith({
    Id? entityId,
  }) {
    return ChatMessageEntityInput(
      entityId: entityId ?? this.entityId,
    );
  }
}
