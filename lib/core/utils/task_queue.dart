import 'dart:async';

class TaskQueue<T> {
  Future<T>? _currentExecution;

  /// Request [computation] to be run exclusively.
  ///
  /// Waits for all previously requested operations to complete,
  /// then runs the operation and completes the returned future with the
  /// result.
  Future<T> run(Future<T> Function() computation) async {
    if (_currentExecution != null) {
      await _currentExecution;
    }
    return _currentExecution = computation();
  }
}
