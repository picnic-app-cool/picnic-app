import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/push_notifications/domain/model/get_push_notification_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/model/update_device_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';

class UpdateDeviceTokenUseCase {
  const UpdateDeviceTokenUseCase(
    this._notificationRepository,
    this._userStore,
  );

  final PushNotificationRepository _notificationRepository;
  final UserStore _userStore;

  Future<Either<UpdateDeviceTokenFailure, Unit>> execute({String? token}) async {
    if (!_userStore.isUserLoggedIn) {
      return failure(const UpdateDeviceTokenFailure.unauthenticated());
    }
    final tokenResult = token == null
        ? await _notificationRepository.getDeviceToken()
        : success<GetPushNotificationTokenFailure, String>(token);
    if (tokenResult.isFailure) {
      return failure(UpdateDeviceTokenFailure.unknown(tokenResult.getFailure()));
    }
    final retrievedToken = tokenResult.getSuccess()!;
    if (retrievedToken.isEmpty) {
      return failure(UpdateDeviceTokenFailure.emptyToken('token retrieved from firebase is empty: "$retrievedToken"'));
    }
    debugLog('Sending new FCM device token ( $retrievedToken ) to backend...');

    return _notificationRepository.sendDeviceTokenToBackend(token: retrievedToken);
  }
}
