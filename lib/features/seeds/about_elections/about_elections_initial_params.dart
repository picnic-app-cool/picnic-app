import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class AboutElectionsInitialParams {
  const AboutElectionsInitialParams({
    this.circle,
    this.createPostInput,
    this.createCircleWithoutPost,
  });

  final Circle? circle;
  final CreatePostInput? createPostInput;
  final bool? createCircleWithoutPost;
}
