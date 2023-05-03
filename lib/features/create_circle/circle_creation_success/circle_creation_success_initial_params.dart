import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class CircleCreationSuccessInitialParams {
  const CircleCreationSuccessInitialParams({
    required this.createPostInput,
    required this.circle,
    required this.createCircleWithoutPost,
  });

  final Circle circle;
  final CreatePostInput createPostInput;
  final bool createCircleWithoutPost;
}
