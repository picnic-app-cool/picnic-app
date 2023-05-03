import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/stores/video_mute_store.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';

class VideoPostInitialParams {
  const VideoPostInitialParams({
    required this.post,
    required this.reportId,
    this.mode = PostDetailsMode.feed,
    this.overlaySize = PostOverlaySize.fullscreen,
    this.onPostUpdated,
    this.postsListInfoProvider,
    this.showPostCommentBar = true,
    this.initiallyMuted = false,
    this.allowUnmute = true,
    this.showControls = true,
    this.showTimestamp = true,
    this.showPostSummaryBarAbovePost = false,
  }) : assert(
            initiallyMuted || allowUnmute,
            "you cannot set both initiallyMuted and allowUnmute to false. "
            "if you want the video to be initially unmuted, then allowUnmute needs to be true ");

  final PostsListInfoProvider? postsListInfoProvider;
  final Post post;
  final PostDetailsMode mode;
  final PostOverlaySize overlaySize;

  final Id reportId;
  final Function(Post)? onPostUpdated;
  final bool showPostCommentBar;
  final bool showTimestamp;

  /// whether video's audio should be initially muted. user is still able to unmute video when tapping on mute toggle
  final bool initiallyMuted;

  /// whether video's audio should be forcibly muted and not allowed to be unmuted. comes handy when we want to display
  /// videos that should ignore global "muted/unmuted" setting stored in [VideoMuteStore]
  final bool allowUnmute;
  final bool showControls;

  final bool showPostSummaryBarAbovePost;
}
