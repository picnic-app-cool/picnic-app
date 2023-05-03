import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/update_device_token_use_case.dart';

class ListenDeviceTokenUpdatesUseCase {
  const ListenDeviceTokenUpdatesUseCase(
    this._pushNotificationRepository,
    this._updateDeviceTokenUseCase,
    this._userStore,
  );

  final PushNotificationRepository _pushNotificationRepository;
  final UpdateDeviceTokenUseCase _updateDeviceTokenUseCase;
  final UserStore _userStore;

  Future<void> execute() async {
    //log current token as soon as this usecase is executed
    // ignoring failure as we can't do much about it
    await _pushNotificationRepository.getDeviceToken().doOnSuccessWait(
      (token) async {
        await _tryRegisterTokenInBackend(token);
      },
    );
    _pushNotificationRepository.setDeviceTokenUpdateListener((newToken) {
      _tryRegisterTokenInBackend(newToken);
    });
  }

  Future<void> _tryRegisterTokenInBackend(String newToken) async {
    if (_userStore.isUserLoggedIn) {
      await _updateDeviceTokenUseCase.execute(token: newToken);
    }
  }
}
