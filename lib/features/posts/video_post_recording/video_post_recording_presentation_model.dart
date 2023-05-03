import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class VideoPostRecordingPresentationModel implements VideoPostRecordingViewModel {
  /// Creates the initial state
  VideoPostRecordingPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    VideoPostRecordingInitialParams initialParams,
  )   : cameraController = initialParams.cameraController,
        recordingDuration = Duration.zero,
        recordingMaxDuration = Constants.maxVideoPostDuration;

  /// Used for the copyWith method
  VideoPostRecordingPresentationModel._({
    required this.cameraController,
    required this.recordingDuration,
    required this.recordingMaxDuration,
  });

  final Duration recordingDuration;
  final Duration recordingMaxDuration;

  @override
  final PicnicCameraController cameraController;

  @override
  VideoRecordingState get recordingState => cameraController.videoRecordingState;

  @override
  bool get flashEnabled => cameraController.isFlashEnabled;

  @override
  double get recordingPercent => recordingDuration.inMilliseconds / recordingMaxDuration.inMilliseconds;

  VideoPostRecordingPresentationModel copyWith({
    PicnicCameraController? cameraController,
    Duration? recordingDuration,
    Duration? recordingMaxDuration,
  }) {
    return VideoPostRecordingPresentationModel._(
      cameraController: cameraController ?? this.cameraController,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      recordingMaxDuration: recordingMaxDuration ?? this.recordingMaxDuration,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class VideoPostRecordingViewModel {
  PicnicCameraController get cameraController;
  VideoRecordingState get recordingState;
  bool get flashEnabled;
  double get recordingPercent;
}
