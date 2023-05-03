import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class PollPostInitialParams {
  const PollPostInitialParams({
    required this.post,
    required this.reportId,
    this.mode = PostDetailsMode.feed,
    this.overlaySize = PostOverlaySize.fullscreen,
    this.onPostUpdated,
    this.showPostCommentBar = true,
    this.showTimestamp = true,
    this.showPostSummaryBarAbovePost = false,
  });

  final PostDetailsMode mode;
  final Post post;
  final PostOverlaySize overlaySize;
  final Function(Post)? onPostUpdated;
  final Id reportId;
  final bool showPostCommentBar;
  final bool showTimestamp;
  final bool showPostSummaryBarAbovePost;
}
