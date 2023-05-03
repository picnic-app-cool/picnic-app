import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';

class TextPostProfileInitialParams {
  const TextPostProfileInitialParams({
    required this.post,
    this.mode = PostDetailsMode.postsTab,
    this.onPostUpdated,
    this.showTimestamp = true,
    this.showPostSummaryBarAbovePost = false,
  });

  final PostDetailsMode mode;

  final Post post;

  final Function(Post)? onPostUpdated;

  final bool showTimestamp;

  final bool showPostSummaryBarAbovePost;

  PostOverlayInitialParams get postOverlayInitialParams {
    return PostOverlayInitialParams(
      post: post,
      messenger: PostOverlayMediator(
        reportActionTaken: (_) => doNothing(),
        postUpdated: (_) => doNothing(),
      ),
      reportId: const Id.empty(),
      circleId: post.circle.id,
      displayOptions: const PostDisplayOptions.empty(),
    );
  }
}
