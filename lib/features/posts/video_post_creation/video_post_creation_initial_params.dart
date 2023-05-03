import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';

class VideoPostCreationInitialParams {
  const VideoPostCreationInitialParams({
    required this.cameraController,
    required this.onTapPost,
    required this.nativeMediaPickerPostCreationEnabled,
    this.circle,
  });

  final ValueChanged<CreatePostInput> onTapPost;
  final PicnicCameraController cameraController;
  final bool nativeMediaPickerPostCreationEnabled;
  final Circle? circle;
}
