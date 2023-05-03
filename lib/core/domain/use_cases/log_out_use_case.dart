import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/log_out_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/repositories/cache_management_repository.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';
import 'package:picnic_app/core/domain/repositories/session_expired_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';

class LogOutUseCase {
  const LogOutUseCase(
    this._userStore,
    this._localStorageRepository,
    this._sessionExpiredRepository,
    this._pushNotificationRepository,
    this._analyticsRepository,
    this._cacheManagementRepository,
    this._authTokenRepository,
  );

  final LocalStorageRepository _localStorageRepository;
  final AuthTokenRepository _authTokenRepository;
  final SessionExpiredRepository _sessionExpiredRepository;
  final PushNotificationRepository _pushNotificationRepository;
  final UserStore _userStore;
  final AnalyticsRepository _analyticsRepository;
  final CacheManagementRepository _cacheManagementRepository;

  Future<Either<LogOutFailure, Unit>> execute() {
    _userStore.privateProfile = const PrivateProfile.empty();
    _sessionExpiredRepository.clearHandledTokens();
    _pushNotificationRepository.clearToken();
    _cacheManagementRepository.cleanCache();
    _analyticsRepository.setUser(const User.anonymous());
    return _authTokenRepository.deleteAuthToken().mapFailure(LogOutFailure.unknown).flatMap(
          (a) => _localStorageRepository
              .saveCurrentUser(user: const PrivateProfile.anonymous())
              .mapFailure((fail) => LogOutFailure.unknown(fail)),
        );
  }
}
