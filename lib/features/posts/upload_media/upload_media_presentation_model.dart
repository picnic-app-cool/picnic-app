import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class UploadMediaPresentationModel implements UploadMediaViewModel {
  /// Creates the initial state
  UploadMediaPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    UploadMediaInitialParams initialParams,
  ) : createPostInput = initialParams.createPostInput;

  /// Used for the copyWith method
  UploadMediaPresentationModel._({
    required this.createPostInput,
  });

  @override
  final CreatePostInput createPostInput;

  UploadMediaPresentationModel copyWith(
    CreatePostInput? createPostInput,
  ) {
    return UploadMediaPresentationModel._(
      createPostInput: createPostInput ?? this.createPostInput,
    );
  }

  UploadMediaPresentationModel byUpdatingContent(PostContentInput content) => copyWith(
        createPostInput.copyWith(content: content),
      );

  UploadMediaPresentationModel byUpdatingContentText(String value) {
    switch (createPostInput.content.type) {
      case PostType.image:
        return copyWith(
          createPostInput.copyWith(
            content: (createPostInput.content as ImagePostContentInput).copyWith(text: value),
          ),
        );
      case PostType.video:
        return copyWith(
          createPostInput.copyWith(
            content: (createPostInput.content as VideoPostContentInput).copyWith(text: value),
          ),
        );
      case PostType.link:
      case PostType.poll:
      case PostType.text:
      case PostType.unknown:
        return this;
    }
  }
}

/// Interface to expose fields used by the view (page).
abstract class UploadMediaViewModel {
  CreatePostInput get createPostInput;
}
