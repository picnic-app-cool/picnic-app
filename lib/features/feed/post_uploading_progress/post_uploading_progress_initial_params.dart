import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class PostUploadingProgressInitialParams {
  PostUploadingProgressInitialParams({
    required this.onPostToBeShown,
  });

  Function(Post) onPostToBeShown;
}
