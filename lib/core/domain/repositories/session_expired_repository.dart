import 'dart:async';

abstract class SessionExpiredRepository {
  void addListener(SessionExpiredListener listener);

  void removeListener(SessionExpiredListener listener);

  void clearHandledTokens();
}

typedef SessionExpiredListener = FutureOr<void> Function();
