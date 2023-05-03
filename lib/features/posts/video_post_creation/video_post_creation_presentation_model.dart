import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class VideoPostCreationPresentationModel implements VideoPostCreationViewModel {
  /// Creates the initial state
  VideoPostCreationPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    VideoPostCreationInitialParams initialParams,
  )   : cameraController = initialParams.cameraController,
        onPostUpdatedCallback = initialParams.onTapPost,
        nativeMediaPickerPostCreationEnabled = initialParams.nativeMediaPickerPostCreationEnabled,
        circle = initialParams.circle;

  /// Used for the copyWith method
  VideoPostCreationPresentationModel._({
    required this.cameraController,
    required this.onPostUpdatedCallback,
    required this.nativeMediaPickerPostCreationEnabled,
    required this.circle,
  });

  final Function(CreatePostInput) onPostUpdatedCallback;

  final PicnicCameraController cameraController;

  @override
  final bool nativeMediaPickerPostCreationEnabled;

  final Circle? circle;

  @override
  String get circleName => circle?.name ?? '';

  @override
  bool get postingEnabled => circle?.videoPostingEnabled ?? true;

  VideoPostCreationPresentationModel copyWith({
    PicnicCameraController? cameraController,
    Function(CreatePostInput)? onPostUpdatedCallback,
    bool? nativeMediaPickerPostCreationEnabled,
    Circle? circle,
  }) {
    return VideoPostCreationPresentationModel._(
      cameraController: cameraController ?? this.cameraController,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      nativeMediaPickerPostCreationEnabled:
          nativeMediaPickerPostCreationEnabled ?? this.nativeMediaPickerPostCreationEnabled,
      circle: circle ?? this.circle,
    );
  }

  CreatePostInput createPostInput(String path) => CreatePostInput(
        circleId: const Id.empty(), // circle id is added in the last step
        content: VideoPostContentInput(videoFilePath: path),
        sound: const Sound.empty(),
      );
}

/// Interface to expose fields used by the view (page).
abstract class VideoPostCreationViewModel {
  bool get nativeMediaPickerPostCreationEnabled;

  bool get postingEnabled;

  String get circleName;
}
