import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class BasicChat extends Equatable {
  const BasicChat({
    required this.name,
    required this.id,
    required this.participantsCount,
    required this.chatType,
    required this.latestMessages,
    required this.createdAtString,
    required this.participants,
    required this.image,
    this.notificationCount = 0,
    this.unreadMessagesCount = 0,
  });

  const BasicChat.empty()
      : name = '',
        id = const Id.none(),
        createdAtString = '',
        participantsCount = 0,
        chatType = ChatType.single,
        notificationCount = 0,
        latestMessages = const PaginatedList.empty(),
        participants = const PaginatedList.empty(),
        image = const ImageUrl.empty(),
        unreadMessagesCount = 0;

  final Id id;
  final String name;
  final int participantsCount;
  final PaginatedList<ChatMessage> latestMessages;
  final PaginatedList<User> participants;
  final int notificationCount;
  final String createdAtString;
  final ChatType chatType;
  final ImageUrl image;
  final int unreadMessagesCount;

  static const _minGroupSize = 2;

  ChatMessage get latestMessage =>
      latestMessages.items.isNotEmpty ? latestMessages.items.first : const ChatMessage.empty();

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  @override
  List<Object?> get props => [
        name,
        id,
        participantsCount,
        latestMessages,
        notificationCount,
        createdAtString,
        chatType,
        participants,
        image,
        unreadMessagesCount,
      ];

  bool get isGroup => participantsCount > _minGroupSize;

  BasicChat copyWith({
    Id? id,
    String? name,
    int? participantsCount,
    PaginatedList<ChatMessage>? latestMessages,
    PaginatedList<User>? participants,
    int? notificationCount,
    String? createdAtString,
    ChatType? chatType,
    ImageUrl? image,
    int? unreadMessagesCount,
  }) {
    return BasicChat(
      id: id ?? this.id,
      name: name ?? this.name,
      participantsCount: participantsCount ?? this.participantsCount,
      latestMessages: latestMessages ?? this.latestMessages,
      participants: participants ?? this.participants,
      notificationCount: notificationCount ?? this.notificationCount,
      createdAtString: createdAtString ?? this.createdAtString,
      chatType: chatType ?? this.chatType,
      image: image ?? this.image,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
    );
  }

  Chat toChat({required BasicCircle circle}) {
    return Chat(
      id: id,
      name: name,
      participantsCount: participantsCount,
      latestMessages: latestMessages,
      participants: participants,
      notificationCount: notificationCount,
      createdAtString: createdAtString,
      chatType: chatType,
      image: image,
      circle: circle,
      unreadMessagesCount: unreadMessagesCount,
    );
  }
}
