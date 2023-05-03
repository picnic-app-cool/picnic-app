import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class CircleConfigInitialParams {
  const CircleConfigInitialParams({
    this.createPostInput = const CreatePostInput.empty(),
    this.createCircleWithoutPost = false,
    this.createCircleInput = const CircleInput.empty(),
    this.isNewCircle = false,
    this.circle = const Circle.empty(),
  });

  final bool createCircleWithoutPost;
  final CreatePostInput createPostInput;
  final CircleInput createCircleInput;
  final bool isNewCircle;
  final Circle circle;
}
