import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class NotificationPostComment extends Equatable implements Notification {
  const NotificationPostComment({
    required this.message,
    required this.postId,
  });

  final Id postId;

  @override
  final String message;

  @override
  NotificationType get type => NotificationType.postComment;

  @override
  List<Object?> get props => [
        message,
        postId,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.post(postId: postId);
}
