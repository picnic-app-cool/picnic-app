import 'dart:async';

class PeriodicTaskExecutor {
  Timer? _timer;
  bool Function() _shouldStopCallback = () => false;

  /// runs the given [task] periodically
  ///
  /// params:
  /// [shouldStop] - callback to check whether the executor should stop running the periodic task, called just after
  /// each invocation of [task]
  /// [period] - how often to run the task
  /// [runOnStart] - whether to run the task immediately after start or after the [period] passes
  void start({
    bool runOnStart = true,
    required Duration period,
    required FutureOr<void> Function() task,
    bool Function()? shouldStop,
  }) {
    _shouldStopCallback = shouldStop ?? () => false;
    if (runOnStart) {
      task();
    }
    _timer = Timer.periodic(
      period,
      (timer) async {
        await task();
        if (_shouldStopCallback()) {
          cancel();
        }
      },
    );
  }

  /// cancels the periodic task
  void cancel() => _timer?.cancel();
}
