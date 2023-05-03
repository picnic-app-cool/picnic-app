import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

typedef NotificationsFilter = bool Function(Notification notification);

abstract class LiveEventsRepository {
  /// Allows for listening chat-related events like message received, user connected etc.
  /// this is a single-subscription stream.
  ///
  /// IMPORTANT: make sure to unsubscribe when finished to save resources!!!
  Future<LiveDataClient<ChatEvent>> getChatLiveDataClient();

  Future<Stream<Notification>> getInAppNotificationEvents();

  Future<void> switchInAppNotifications({required bool enable});

  Future<Stream<LiveEvent<ChatEvent>>> startUnreadChatUpdateListening(Id userId);

  void addNotificationsFilter(NotificationsFilter filter);

  void removeNotificationsFilter(NotificationsFilter filter);
}
