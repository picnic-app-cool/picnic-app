//ignore_for_file: ban-name
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';

class FirebaseProvider {
  FirebaseProvider(
    this._platformProvider,
  );

  final DevicePlatformProvider _platformProvider;

  FirebaseAuth? get auth {
    switch (_platformProvider.currentPlatform) {
      case DevicePlatform.ios:
      case DevicePlatform.android:
      case DevicePlatform.macos:
        return FirebaseAuth.instance;
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.other:
        return null;
    }
  }

  FirebaseAnalytics? get analytics {
    switch (_platformProvider.currentPlatform) {
      case DevicePlatform.ios:
      case DevicePlatform.android:
      case DevicePlatform.macos:
        return FirebaseAnalytics.instance;
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.other:
        return null;
    }
  }

  FirebaseCrashlytics? get crashlytics {
    switch (_platformProvider.currentPlatform) {
      case DevicePlatform.ios:
      case DevicePlatform.android:
      case DevicePlatform.macos:
        return FirebaseCrashlytics.instance;
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.other:
        return null;
    }
  }

  FirebaseMessaging? get messaging {
    switch (_platformProvider.currentPlatform) {
      case DevicePlatform.ios:
      case DevicePlatform.android:
      case DevicePlatform.macos:
        return FirebaseMessaging.instance;
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.other:
        return null;
    }
  }

  Stream<RemoteMessage> get onMessageOpenedApp => FirebaseMessaging.onMessageOpenedApp;

  void onBackgroundMessage(Future<void> Function(RemoteMessage message) firebaseMessagingBackgroundHandler) =>
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
