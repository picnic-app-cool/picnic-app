import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class NotificationElectionSomeonePassed extends Equatable implements Notification {
  const NotificationElectionSomeonePassed({
    required this.message,
    required this.circleId,
  });

  @override
  final String message;
  final Id circleId;

  @override
  NotificationType get type => NotificationType.electionSomeonePassed;

  @override
  List<Object?> get props => [
        message,
        circleId,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.election(circleId: circleId);
}
