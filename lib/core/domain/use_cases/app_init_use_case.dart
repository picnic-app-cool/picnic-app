import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_init_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_feature_flags_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_unread_chats_use_case.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/listen_device_token_updates_use_case.dart';
import 'package:picnic_app/picnic_app.dart';

/// Takes care of the entire app initialization, populating stores with values, setting up the state the entire app
class AppInitUseCase {
  const AppInitUseCase(
    this._librariesInitializers,
    this._localStorageRepository,
    this._userStore,
    this._getFeatureFlagsUseCase,
    this._listenDeviceTokenUpdatesUseCase,
    this._analyticsRepository,
    this._setAppInfoUseCase,
    this._unreadCountersStore,
    this._getUnreadChatsUseCase,
  );

  final List<LibraryInitializer> _librariesInitializers;
  final LocalStorageRepository _localStorageRepository;
  final UserStore _userStore;
  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;
  final ListenDeviceTokenUpdatesUseCase _listenDeviceTokenUpdatesUseCase;
  final AnalyticsRepository _analyticsRepository;
  final SetAppInfoUseCase _setAppInfoUseCase;
  final UnreadCountersStore _unreadCountersStore;
  final GetUnreadChatsUseCase _getUnreadChatsUseCase;

  Future<Either<AppInitFailure, Unit>> execute() async {
    if (PicnicApp.appInitCompleter.isCompleted) {
      PicnicApp.appInitCompleter = Completer();
    }
    await Future.wait(_librariesInitializers.map((it) => it.init()));

    /// ignoring the result, if it fails we cannot do anything about that and only assume default values
    await _getFeatureFlagsUseCase.execute();

    await _setAppInfoUseCase.execute();

    return _getCurrentUserFromStorage().doOnSuccessWait(
      (privateProfile) async {
        _userStore.privateProfile = privateProfile ?? const PrivateProfile.empty();
        _analyticsRepository.setUser(privateProfile?.user);
        PicnicApp.appInitCompleter.complete();
        if (_userStore.isUserLoggedIn) {
          unawaited(
            _getUnreadChatsUseCase
                .execute()
                .doOn(success: (unreadChats) => _unreadCountersStore.unreadChats = unreadChats),
          );
        }

        /// ignoring the result, if listening fails, we can only log the problem (which is done internally)
        await _listenDeviceTokenUpdatesUseCase.execute();
      },
    ).mapSuccess((_) => unit);
  }

  Future<Either<AppInitFailure, PrivateProfile?>> _getCurrentUserFromStorage() {
    return _localStorageRepository.getCurrentUser().mapFailure((fail) => AppInitFailure.unknown(fail));
  }
}
