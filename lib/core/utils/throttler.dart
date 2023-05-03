import 'dart:async';

/// Used to throttle the operation. Operation runs immediately,
/// but all subsequent operations are ignored for provided duration
class Throttler {
  Timer? _timer;

  /// Runs [func] and ignores all further calls to [throttle] during [duration]
  T? throttle<T>(Duration duration, T Function() func) {
    if (_timer == null) {
      final result = func();
      _timer = Timer(duration, () => _timer = null);
      return result;
    }
    return null;
  }

  void cancel() {
    _timer?.cancel();
  }
}
