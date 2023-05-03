import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PhotoPostCreationPresentationModel implements PhotoPostCreationViewModel {
  /// Creates the initial state
  PhotoPostCreationPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PhotoPostCreationInitialParams initialParams,
  )   : onPostUpdatedCallback = initialParams.onTapPost,
        nativeMediaPickerPostCreationEnabled = initialParams.nativeMediaPickerPostCreationEnabled,
        circle = initialParams.circle;

  /// Used for the copyWith method
  PhotoPostCreationPresentationModel._({
    required this.onPostUpdatedCallback,
    required this.nativeMediaPickerPostCreationEnabled,
    required this.circle,
  });

  final Function(CreatePostInput) onPostUpdatedCallback;

  final Circle? circle;

  @override
  final bool nativeMediaPickerPostCreationEnabled;

  @override
  String get circleName => circle?.name ?? '';

  @override
  bool get postingEnabled => circle?.imagePostingEnabled ?? true;

  PhotoPostCreationPresentationModel copyWith({
    Function(CreatePostInput)? onPostUpdatedCallback,
    bool? nativeMediaPickerPostCreationEnabled,
    Circle? circle,
  }) {
    return PhotoPostCreationPresentationModel._(
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      nativeMediaPickerPostCreationEnabled:
          nativeMediaPickerPostCreationEnabled ?? this.nativeMediaPickerPostCreationEnabled,
      circle: circle ?? this.circle,
    );
  }

  CreatePostInput createPostInput(String path) => CreatePostInput(
        circleId: const Id.empty(), // circle id is added in the last step
        content: const ImagePostContentInput.empty().copyWith(imageFilePath: path), sound: const Sound.empty(),
      );
}

/// Interface to expose fields used by the view (page).
abstract class PhotoPostCreationViewModel {
  bool get nativeMediaPickerPostCreationEnabled;

  bool get postingEnabled;

  String get circleName;
}
