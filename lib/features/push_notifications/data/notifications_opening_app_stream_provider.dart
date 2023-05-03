import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:picnic_app/core/data/model/notification_payload.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/features/push_notifications/data/firebase_messaging_wrapper.dart';

class NotificationsOpeningAppStreamProvider {
  NotificationsOpeningAppStreamProvider(this.firebaseMessagingWrapper);

  final FirebaseMessagingWrapper firebaseMessagingWrapper;

  StreamController<RemoteMessage>? _messagesBroadcaster;

  Stream<Notification> get stream => _ensureMessagesBroadcaster().stream.map(
        (event) => NotificationPayload.fromJson(event.data).toNotification(),
      );

  Future<void> _broadcastInitialMessage() async {
    final message = await firebaseMessagingWrapper.getInitialMessage();
    if (message != null) {
      _ensureMessagesBroadcaster().sink.add(message);
    }
  }

  void _startListeningMessages() =>
      _ensureMessagesBroadcaster().addStream(firebaseMessagingWrapper.onMessageOpenedApp() ?? const Stream.empty());

  void _dispose() {
    _messagesBroadcaster?.close();
    _messagesBroadcaster = null;
  }

  StreamController<RemoteMessage> _ensureMessagesBroadcaster() {
    return _messagesBroadcaster ??= StreamController<RemoteMessage>.broadcast(
      onListen: () async {
        await _broadcastInitialMessage();
        _startListeningMessages();
      },
      onCancel: _dispose,
    );
  }
}
