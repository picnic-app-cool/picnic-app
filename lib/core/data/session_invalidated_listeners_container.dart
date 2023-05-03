import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/handle_force_log_out_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/core/utils/task_queue.dart';

class SessionInvalidatedListenersContainer {
  final _sessionExpiredListeners = <OnSessionInvalidatedListener>[];
  final _sessionInvalidatedTaskQueue = TaskQueue<Either<HandleForceLogOutFailure, Unit>>();
  final _handledAuthorizations = <int>{};

  Future<Either<HandleForceLogOutFailure, Unit>> onSessionInvalidated({
    required int tokenHashCode,
  }) {
    return _sessionInvalidatedTaskQueue.run(
      () {
        return _onSessionInvalidated(
          tokenHashCode: tokenHashCode,
        );
      },
    );
  }

  void registerOnSessionInvalidatedListener(OnSessionInvalidatedListener listener) {
    _sessionExpiredListeners.add(listener);
  }

  void unregisterOnSessionInvalidatedListener(OnSessionInvalidatedListener listener) {
    _sessionExpiredListeners.remove(listener);
  }

  void clearHandledTokens() => _handledAuthorizations.clear();

  Future<Either<HandleForceLogOutFailure, Unit>> _onSessionInvalidated({
    required int tokenHashCode,
  }) async {
    if (_handledAuthorizations.contains(tokenHashCode)) {
      return success(unit);
    }

    final exceptionsList = [];
    for (final listener in _sessionExpiredListeners) {
      try {
        await listener(tokenHashCode);
      } catch (ex, stack) {
        logError(ex, stack: stack);
        exceptionsList.add(ex);
      }
    }

    if (exceptionsList.isNotEmpty) {
      return failure(HandleForceLogOutFailure.unknown(exceptionsList));
    }

    debugLog("'_handledAuthorizations', adding handled authorization: $_handledAuthorizations");
    _handledAuthorizations.add(tokenHashCode);
    return success(unit);
  }
}

typedef OnSessionInvalidatedListener = FutureOr<void> Function(int tokenHashCode);
