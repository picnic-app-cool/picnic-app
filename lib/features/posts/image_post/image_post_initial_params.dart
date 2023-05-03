import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class ImagePostInitialParams {
  const ImagePostInitialParams({
    required this.post,
    required this.reportId,
    this.mode = PostDetailsMode.feed,
    this.overlaySize = PostOverlaySize.fullscreen,
    this.onPostUpdated,
    this.showPostCommentBar = true,
    this.showPostSummaryBarAbovePost = true,
    this.showTimestamp = true,
  });

  final PostDetailsMode mode;
  final Post post;
  final PostOverlaySize overlaySize;
  final Id reportId;
  final Function(Post)? onPostUpdated;
  final bool showPostCommentBar;
  final bool showPostSummaryBarAbovePost;
  final bool showTimestamp;
}
