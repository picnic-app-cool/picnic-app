import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FullScreenImagePostPresentationModel implements FullScreenImagePostViewModel {
  /// Creates the initial state
  FullScreenImagePostPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FullScreenImagePostInitialParams initialParams,
  ) : imagePostContent = initialParams.imageContent;

  /// Used for the copyWith method
  FullScreenImagePostPresentationModel._({
    required this.imagePostContent,
  });

  @override
  final ImagePostContent imagePostContent;

  FullScreenImagePostPresentationModel copyWith({
    ImagePostContent? imagePostContent,
  }) {
    return FullScreenImagePostPresentationModel._(
      imagePostContent: imagePostContent ?? this.imagePostContent,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FullScreenImagePostViewModel {
  ImagePostContent get imagePostContent;
}
