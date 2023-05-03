import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class TextPostCreationInitialParams {
  const TextPostCreationInitialParams({
    required this.onTapPost,
    this.circle,
  });

  final ValueChanged<CreatePostInput> onTapPost;
  final Circle? circle;
}
