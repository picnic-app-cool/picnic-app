import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/domain/use_cases/increment_app_badge_count_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/picnic_app_init_params.dart';

class FirebaseMessagingWrapper {
  const FirebaseMessagingWrapper(
    this._firebaseProvider,
  );

  final FirebaseProvider _firebaseProvider;

  Stream<String>? get onTokenRefresh => _firebaseProvider.messaging?.onTokenRefresh;

  Future<RemoteMessage?>? getInitialMessage() => _firebaseProvider.messaging?.getInitialMessage();

  Stream<RemoteMessage>? onMessageOpenedApp() => _firebaseProvider.onMessageOpenedApp;

  Future<String?>? getDeviceToken() => _firebaseProvider.messaging?.getToken();

  Future<void>? clearToken() => _firebaseProvider.messaging?.deleteToken();
}

/// From https://firebase.google.com/docs/cloud-messaging/flutter/receive
/// 1. It must not be an anonymous function.
/// 2. It must be a top-level function (e.g. not a class method which requires initialization).
/// 3. It must be annotated with @pragma('vm:entry-point') right above the function declaration (otherwise it may be removed during tree shaking for release mode).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (!getIt.isRegistered<IncrementAppBadgeCountUseCase>()) {
    configureDependencies(PicnicAppInitParams.defaultForPlatform());
    await getIt.allReady();
  }
  await getIt<IncrementAppBadgeCountUseCase>().execute();
}
