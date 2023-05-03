import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

class UploadMediaInitialParams {
  const UploadMediaInitialParams({
    required this.createPostInput,
  });

  final CreatePostInput createPostInput;
}
