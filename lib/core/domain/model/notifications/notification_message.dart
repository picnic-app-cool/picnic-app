import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_chat.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class NotificationMessage extends Equatable implements Notification {
  const NotificationMessage({
    required this.message,
    required this.chatId,
  });

  final Id chatId;

  @override
  final String message;

  @override
  NotificationType get type => NotificationType.message;

  @override
  List<Object?> get props => [
        message,
        chatId,
      ];

  @override
  DeepLink toDeepLink() => DeepLinkChat(chatId: chatId);
}
