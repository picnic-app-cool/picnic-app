import 'package:picnic_app/core/utils/current_time_provider.dart';

class PicnicCameraDurationCounter {
  PicnicCameraDurationCounter(this._currentTimeProvider);

  final CurrentTimeProvider _currentTimeProvider;

  DateTime? _recordingStartTime;
  DateTime? _recordingEndTime;
  DateTime? _recordingPauseStartTime;
  Duration _allPausesDuration = Duration.zero;

  Duration get duration {
    if (_recordingStartTime == null) {
      return Duration.zero;
    }

    final tillTime = _recordingEndTime ?? _recordingPauseStartTime ?? _currentTimeProvider.currentTime;
    return tillTime.difference(_recordingStartTime!) - _allPausesDuration;
  }

  void onRecordingStarted() {
    _recordingStartTime = _currentTimeProvider.currentTime;
  }

  void onRecordingPaused() {
    _recordingPauseStartTime = _currentTimeProvider.currentTime;
  }

  void onRecordingResumed() {
    final pauseDuration = _currentTimeProvider.currentTime.difference(_recordingPauseStartTime!);
    _recordingPauseStartTime = null;
    _allPausesDuration += pauseDuration;
  }
}
