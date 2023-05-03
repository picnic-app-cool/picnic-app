import 'dart:async';

import 'package:picnic_app/core/domain/use_cases/add_session_expired_listener_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/log_out_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/remove_session_expired_listener_use_case.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/app_init/force_log_out_observer/force_log_out_observer_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';

class ForceLogOutObserverPresenter {
  ForceLogOutObserverPresenter(
    this._navigator,
    this._logOutUseCase,
    this._addSessionExpiredListenerUseCase,
    this._removeSessionExpiredListenerUseCase,
  );

  final ForceLogOutObserverNavigator _navigator;
  final AddSessionExpiredListenerUseCase _addSessionExpiredListenerUseCase;
  final RemoveSessionExpiredListenerUseCase _removeSessionExpiredListenerUseCase;
  final LogOutUseCase _logOutUseCase;

  void onInit() {
    _addSessionExpiredListenerUseCase.execute(onLoggedOut);
  }

  Future<void> onLoggedOut() async {
    debugLog("session invalidated, logging user out...");
    await _logOutUseCase.execute();
    debugLog("opening onboarding after logout.");
    unawaited(_navigator.replaceAllToOnboarding(const OnboardingInitialParams()));
  }

  void close() {
    _removeSessionExpiredListenerUseCase.execute(onLoggedOut);
  }
}
