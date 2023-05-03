import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

class DeepLinkChat extends Equatable implements DeepLink {
  const DeepLinkChat({
    required this.chatId,
  });

  const DeepLinkChat.empty() : chatId = const Id.empty();

  final Id chatId;

  @override
  DeepLinkType get type => DeepLinkType.chat;

  @override
  List<Object?> get props => [type];

  @override
  bool get requiresAuthenticatedUser => true;

  DeepLinkChat copyWith({
    Id? chatId,
  }) {
    return DeepLinkChat(
      chatId: chatId ?? this.chatId,
    );
  }
}
