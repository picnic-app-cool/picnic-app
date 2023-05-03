import 'dart:async';

/// Used to debounce the operation. i.e operation is scheduled to run in the future,
/// if there is a new operation scheduled to run before the previous is executed,
/// the previous one gets cancelled and the timer is reset
/// useful for example to perform action few milliseconds after user stops typing text
class Debouncer {
  Timer? _timer;

  void debounce(Duration duration, dynamic Function() func) {
    _timer?.cancel();
    _timer = Timer(duration, func);
  }

  void cancel() {
    _timer?.cancel();
  }
}
