//ignore_for_file: forbidden_import_in_presentation
// TODO: remove ignore, it is here because of package:meta/meta.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_navigator.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presentation_model.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';

class VideoPostRecordingPresenter extends Cubit<VideoPostRecordingViewModel> {
  VideoPostRecordingPresenter(
    super.model,
    this.navigator, {
    @visibleForTesting bool avoidTimers = false,
  }) : _avoidTimers = avoidTimers;

  final VideoPostRecordingNavigator navigator;

  final bool _avoidTimers;

  Timer? _recordingDurationTimer;

  VideoPostRecordingPresentationModel get _model => state as VideoPostRecordingPresentationModel;

  void onInit() {
    if (_model.recordingState == VideoRecordingState.notRecording) {
      _model.cameraController.startVideoRecording();
    }
    if (!_avoidTimers) {
      _recordingDurationTimer = Timer.periodic(
        const ExtraShortDuration(),
        (_) => _onRecordingDurationTimerCallback(),
      );
    }
  }

  Future<void> onTapSwitchCameraDirection() async {
    await _model.cameraController.switchCameraDirection();
  }

  Future<void> onTapRecord() async {
    await _model.cameraController.startVideoRecording();
  }

  Future<void> onTapSwitchFlash() async {
    await _model.cameraController.switchFlashMode();
  }

  Future<void> onTapPause() async {
    await _model.cameraController.pauseVideoRecording();
  }

  Future<void> onTapSend() async {
    _disposeRecordingDurationTimer();
    await _recorded();
  }

  @override
  Future<void> close() async {
    _disposeRecordingDurationTimer();
    if (_model.recordingState == VideoRecordingState.recording || //
        _model.recordingState == VideoRecordingState.paused) {
      await _model.cameraController.stopVideoRecording();
    }
    return super.close();
  }

  void _onRecordingDurationTimerCallback() {
    final recordingDuration = _model.cameraController.videoRecordingDuration;
    tryEmit(_model.copyWith(recordingDuration: recordingDuration));
    if (_model.recordingPercent >= 1) {
      _disposeRecordingDurationTimer();
      _recorded();
    }
  }

  Future<void> _recorded() async {
    final filePath = await _model.cameraController.stopVideoRecording();
    if (filePath != null) {
      navigator.closeWithResult(filePath);
    }
  }

  void _disposeRecordingDurationTimer() {
    _recordingDurationTimer?.cancel();
    _recordingDurationTimer = null;
  }
}
