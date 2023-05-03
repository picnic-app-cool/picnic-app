import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_duration_counter.dart';
import 'package:picnic_app/main.dart';

const _defaultCameraDirection = CameraLensDirection.back;

class PicnicCameraController extends ChangeNotifier {
  PicnicCameraController(this._currentTimeProvider);

  final CurrentTimeProvider _currentTimeProvider;

  late final List<CameraDescription> _cameras;
  late final List<CameraLensDirection> _availableCameraDirections;

  CameraLensDirection? _currentCameraLensDirection;
  CameraController? _cameraController;
  bool _initialized = false;

  VideoRecordingState _videoRecordingState = VideoRecordingState.notRecording;
  bool _isFlashEnabled = false;

  late PicnicCameraDurationCounter _durationCounter = PicnicCameraDurationCounter(_currentTimeProvider);

  VideoRecordingState get videoRecordingState => _videoRecordingState;

  Duration get videoRecordingDuration => _durationCounter.duration;

  bool get isFlashEnabled => _isFlashEnabled;

  bool get isReady => _cameraController != null && _cameraController!.value.isInitialized;

  CameraController? get internalController => _cameraController;

  bool get initialized => _initialized;

  Future<void> init() async {
    _cameras = await availableCameras();
    _availableCameraDirections = _cameras.map((e) => e.lensDirection).toSet().toList();
    _currentCameraLensDirection = _availableCameraDirections.contains(_defaultCameraDirection)
        ? _defaultCameraDirection
        : _availableCameraDirections.firstOrNull;
    await _reloadCamera();
    _initialized = true;
  }

  Future<void> switchCameraDirection() async {
    final nextDirectionIndex =
        (_availableCameraDirections.indexOf(_currentCameraLensDirection!) + 1) % _availableCameraDirections.length;
    _currentCameraLensDirection = _availableCameraDirections[nextDirectionIndex];
    await _reloadCamera();
  }

  Future<void> disable() async {
    final oldCameraController = _cameraController;
    _cameraController = null;
    _resetLocalFields();
    await oldCameraController?.dispose();
  }

  Future<void> enable() async {
    if (!isUnitTests) {
      await _initializeCamera();
    }
  }

  /// Stops recording and resets controller state to default one
  Future<void> reset() async {
    if (videoRecordingState != VideoRecordingState.notRecording) {
      await stopVideoRecording();
    }
    if (isFlashEnabled) {
      await switchFlashMode();
    }
  }

  Future<String?> takePhoto() async {
    _checkCameraInitialized();

    try {
      final file = await _cameraController!.takePicture();
      return file.path;
    } on CameraException catch (e) {
      _handleCameraException(e);
      return null;
    }
  }

  Future<void> startVideoRecording() async {
    assert(
      _videoRecordingState == VideoRecordingState.notRecording || //
          _videoRecordingState == VideoRecordingState.paused,
    );
    _checkCameraInitialized();

    try {
      if (_videoRecordingState == VideoRecordingState.paused) {
        await _cameraController!.resumeVideoRecording();
        _durationCounter.onRecordingResumed();
      } else {
        await _cameraController!.startVideoRecording();
        _durationCounter.onRecordingStarted();
      }
      _videoRecordingState = VideoRecordingState.recording;
    } on CameraException catch (e) {
      _handleCameraException(e);
    }
  }

  Future<void> pauseVideoRecording() async {
    assert(_videoRecordingState == VideoRecordingState.recording);
    _checkCameraInitialized();

    try {
      await _cameraController!.pauseVideoRecording();
      _durationCounter.onRecordingPaused();
      _videoRecordingState = VideoRecordingState.paused;
    } on CameraException catch (e) {
      _handleCameraException(e);
    }
  }

  Future<String?> stopVideoRecording() async {
    assert(
      _videoRecordingState == VideoRecordingState.recording || //
          _videoRecordingState == VideoRecordingState.paused,
    );
    _checkCameraInitialized();

    try {
      final file = await _cameraController!.stopVideoRecording();
      _durationCounter = PicnicCameraDurationCounter(_currentTimeProvider);
      _videoRecordingState = VideoRecordingState.notRecording;
      return file.path;
    } on CameraException catch (e) {
      _handleCameraException(e);
      return null;
    }
  }

  Future<void> switchFlashMode() async {
    _checkCameraInitialized();
    try {
      if (_isFlashEnabled) {
        await _cameraController!.setFlashMode(FlashMode.off);
      } else {
        await _cameraController!.setFlashMode(FlashMode.torch);
      }
      _isFlashEnabled = !_isFlashEnabled;
    } on CameraException catch (e) {
      _handleCameraException(e);
    }
  }

  @override
  void dispose() {
    disable();
    super.dispose();
  }

  void _checkCameraInitialized() {
    final isCameraInitialized = _cameraController?.value.isInitialized ?? false;
    if (!initialized || !isCameraInitialized) {
      throw Exception('Camera is not initialized.');
    }
  }

  void _resetLocalFields() {
    _videoRecordingState = VideoRecordingState.notRecording;
    _isFlashEnabled = false;
    _durationCounter = PicnicCameraDurationCounter(_currentTimeProvider);
  }

  Future<void> _reloadCamera() async {
    final newCamera = _cameras.firstWhereOrNull((e) => e.lensDirection == _currentCameraLensDirection);
    if (newCamera == null) {
      return;
    }

    _resetLocalFields();
    final oldCameraController = _cameraController;
    final cameraController = _cameraController = CameraController(
      newCamera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // old controller must be disposed before we initialize new one, otherwise we'll see nothing
    await oldCameraController?.dispose();

    // If the controller is updated then update the UI.
    cameraController.addListener(() => notifyListeners());

    try {
      await cameraController.initialize();
      if (!kIsWeb) {
        await Future.wait([
          cameraController.getMinExposureOffset(),
          cameraController.getMaxExposureOffset(),
        ]);
      }
    } on CameraException catch (e) {
      _handleCameraException(e);
    }
  }

  // todo: this errors should be forwarded to UI instead of logging them here
  void _handleCameraException(CameraException e) {
    switch (e.code) {
      case 'CameraAccessDenied':
        logError('You have denied camera access.');
        break;
      case 'CameraAccessDeniedWithoutPrompt':
        // iOS only
        logError('Please go to Settings app to enable camera access.');
        break;
      case 'CameraAccessRestricted':
        // iOS only
        logError('Camera access is restricted.');
        break;
      case 'AudioAccessDenied':
        logError('You have denied audio access.');
        break;
      case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
        logError('Please go to Settings app to enable audio access.');
        break;
      case 'AudioAccessRestricted':
        // iOS only
        logError('Audio access is restricted.');
        break;
      default:
        logError(e);
        break;
    }
  }

  Future<void> _initializeCamera() async {
    if (initialized) {
      await _reloadCamera();
    } else {
      await init();
    }
  }
}

enum VideoRecordingState { notRecording, recording, paused }
