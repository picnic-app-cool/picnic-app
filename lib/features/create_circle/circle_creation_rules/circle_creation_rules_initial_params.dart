import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class CircleCreationRulesInitialParams {
  const CircleCreationRulesInitialParams({
    required this.circle,
    required this.createPostInput,
  });

  final Circle circle;

  final CreatePostInput createPostInput;
}
