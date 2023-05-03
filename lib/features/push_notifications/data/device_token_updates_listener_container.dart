import 'dart:async';

import 'package:picnic_app/features/push_notifications/data/firebase_messaging_wrapper.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';

class DeviceTokenUpdatesListenerContainer {
  DeviceTokenUpdatesListenerContainer(this._firebaseMessagingWrapper);

  final FirebaseMessagingWrapper _firebaseMessagingWrapper;

  DeviceTokenListenerCallback? _tokenListenerCallback;
  StreamSubscription<String>? _subscription;

  void setDeviceTokenUpdateListener(DeviceTokenListenerCallback? callback) {
    if (callback == null) {
      _subscription?.cancel();
    } else if (_tokenListenerCallback == null) {
      _subscription = _firebaseMessagingWrapper.onTokenRefresh?.listen((newToken) {
        _updateToken(newToken);
      });
    }
    _tokenListenerCallback = callback;
  }

  void _updateToken(String newToken) => _tokenListenerCallback?.call(newToken);
}
