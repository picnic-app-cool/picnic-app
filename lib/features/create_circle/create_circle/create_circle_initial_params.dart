import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class CreateCircleInitialParams {
  const CreateCircleInitialParams({
    this.createPostInput = const CreatePostInput.empty(),
    this.createCircleWithoutPost = false,
  }) : assert(
          !createCircleWithoutPost || createPostInput == const CreatePostInput.empty(),
          'createPostInput must be empty if createCircleWithoutPost is true',
        );

  final CreatePostInput createPostInput;
  final bool createCircleWithoutPost;
}
