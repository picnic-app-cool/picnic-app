import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/push_notifications/data/device_token_updates_listener_container.dart';
import 'package:picnic_app/features/push_notifications/data/firebase_messaging_wrapper.dart';
import 'package:picnic_app/features/push_notifications/data/model/notification_queries.dart';
import 'package:picnic_app/features/push_notifications/data/notifications_opening_app_stream_provider.dart';
import 'package:picnic_app/features/push_notifications/domain/model/get_push_notification_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/model/update_device_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';

class FcmGraphqlPushNotificationRepository implements PushNotificationRepository {
  FcmGraphqlPushNotificationRepository(
    this._firebaseMessagingWrapper,
    this._gqlClient,
    this._devicePlatformProvider,
    this._deviceTokenUpdatesListenerContainer,
  );

  final FirebaseMessagingWrapper _firebaseMessagingWrapper;
  final GraphQLClient _gqlClient;
  final DevicePlatformProvider _devicePlatformProvider;
  final DeviceTokenUpdatesListenerContainer _deviceTokenUpdatesListenerContainer;
  NotificationsOpeningAppStreamProvider? _streamProvider;

  @override
  Stream<Notification> get pushNotificationOpenedApp => _ensureNotificationsOpeningAppStreamProvider().stream;

  @override
  Future<Either<GetPushNotificationTokenFailure, String>> getDeviceToken() async {
    try {
      final token = await _firebaseMessagingWrapper.getDeviceToken();
      return success(token ?? '');
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(GetPushNotificationTokenFailure.unknown(ex));
    }
  }

  @override
  Future<Either<UpdateDeviceTokenFailure, Unit>> sendDeviceTokenToBackend({
    required String token,
  }) {
    return _gqlClient
        .mutate(
          document: saveDeviceTokenMutation,
          variables: {
            'token': token,
            'platform': _devicePlatformProvider.currentPlatform.value,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['notificationSaveDeviceToken'] as Map<String, dynamic>),
        )
        .mapFailure(UpdateDeviceTokenFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const UpdateDeviceTokenFailure.unknown());
  }

  @override
  void setDeviceTokenUpdateListener(DeviceTokenListenerCallback? callback) {
    _deviceTokenUpdatesListenerContainer.setDeviceTokenUpdateListener(callback);
  }

  @override
  Future<void> clearToken() async => _firebaseMessagingWrapper.clearToken();

  NotificationsOpeningAppStreamProvider _ensureNotificationsOpeningAppStreamProvider() =>
      _streamProvider ??= NotificationsOpeningAppStreamProvider(
        _firebaseMessagingWrapper,
      );
}
