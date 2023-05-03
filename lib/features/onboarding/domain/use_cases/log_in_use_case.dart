import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/set_language_failure.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_language_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_unread_chats_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/model/update_device_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/update_device_token_use_case.dart';
import 'package:picnic_app/features/user_agreement/domain/use_cases/accept_apps_terms_use_case.dart';

class LogInUseCase {
  const LogInUseCase(
    this._authRepository,
    this._userStore,
    this._localStorageRepository,
    this._updateDeviceTokenUseCase,
    this._analyticsRepository,
    this._setLanguageUseCase,
    this._saveAuthTokenUseCase,
    this._getUnreadChatsUseCase,
    this._unreadCountersStore,
    this._acceptAppsTermsUseCase,
  );

  final AuthRepository _authRepository;
  final UserStore _userStore;
  final LocalStorageRepository _localStorageRepository;
  final UpdateDeviceTokenUseCase _updateDeviceTokenUseCase;
  final AnalyticsRepository _analyticsRepository;
  final SetLanguageUseCase _setLanguageUseCase;
  final SaveAuthTokenUseCase _saveAuthTokenUseCase;
  final GetUnreadChatsUseCase _getUnreadChatsUseCase;
  final UnreadCountersStore _unreadCountersStore;
  final AcceptAppsTermsUseCase _acceptAppsTermsUseCase;

  /// Logs user in and persist its data in local storage
  //ignore: long-method
  Future<Either<LogInFailure, AuthResult>> execute(
    LogInCredentials credentials,
  ) async {
    return _authRepository
        .logIn(credentials: credentials)
        .chainOnSuccess(
          (result) => _saveUserInfo(
            result.passedOnboarding ? result.privateProfile : const PrivateProfile.empty(),
          ),
        )
        .chainOnSuccess(
          (result) => _saveAuthToken(
            result.passedOnboarding ? result.authToken : null,
          ),
        )
        .chainOnSuccess((_) => _acceptUserTerms())
        .doOn(success: (success) => _setUserInAnalytics(success.privateProfile.user))
        //intentionally ignoring failures, as it should not cause login to fail
        .doOn(success: (_) => _updateDeviceToken())
        //intentionally ignoring failures, as it should not cause login to fail
        .doOn(success: (result) => _setLanguageCode(result))
        .doOn(fail: (_) => _unauthenticateUser())
        .doOnSuccessWait(
          (result) => _getUnreadChatsUseCase
              .execute()
              .mapSuccess((unreadChats) => _unreadCountersStore.unreadChats = unreadChats),
        );
  }

  Future<Either<SetLanguageFailure, Unit>> _setLanguageCode(AuthResult result) {
    return _setLanguageUseCase.execute(
      languagesCodes: result.privateProfile.languages,
    );
  }

  void _setUserInAnalytics(User user) {
    _analyticsRepository.setUser(user);
  }

  Future<Either<UpdateDeviceTokenFailure, Unit>> _updateDeviceToken() {
    return _updateDeviceTokenUseCase.execute();
  }

  Future<Either<LogInFailure, bool>> _acceptUserTerms() {
    return _acceptAppsTermsUseCase.execute().mapFailure(LogInFailure.unknown);
  }

  Future<Either<LogInFailure, Unit>> _saveUserInfo(PrivateProfile user) async {
    _userStore.privateProfile = user;
    return _localStorageRepository
        .saveCurrentUser(user: user)
        .doOn(fail: (fail) => logError(fail))
        .mapFailure((fail) => LogInFailure.unknown(fail));
  }

  Future<Either<LogInFailure, Unit>> _saveAuthToken(
    AuthToken? authToken,
  ) async {
    return _saveAuthTokenUseCase //
        .execute(authToken: authToken)
        .mapFailure((fail) => LogInFailure.unknown(fail));
  }

  void _unauthenticateUser() {
    _userStore.privateProfile = const PrivateProfile.anonymous();
    _saveAuthToken(const AuthToken.empty());
    _saveUserInfo(const PrivateProfile.anonymous());
    _setUserInAnalytics(const User.anonymous());
  }
}
