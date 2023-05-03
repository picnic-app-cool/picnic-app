import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_post.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class PostDetailsInitialParams {
  PostDetailsInitialParams({
    this.post = const Post.empty(),
    this.postId = const Id.empty(),
    this.reportId = const Id.empty(),
    this.isModOrDirector = false,
    this.onPostUpdated,
    this.mode = PostDetailsMode.details,
  });

  PostDetailsInitialParams.fromDeepLink({
    required DeepLinkPost deepLink,
  })  : post = const Post.empty(),
        reportId = const Id.empty(),
        postId = deepLink.postId,
        isModOrDirector = false,
        mode = PostDetailsMode.details;

  final Post post;

  final Id reportId;

  final Id postId;

  final PostDetailsMode mode;

  final bool isModOrDirector;

  Function(Post)? onPostUpdated;
}
