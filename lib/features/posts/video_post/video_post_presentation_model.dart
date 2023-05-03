import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';

final _videoTappedNeverDateTime = DateTime(-1);

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class VideoPostPresentationModel implements VideoPostViewModel {
  /// Creates the initial state
  VideoPostPresentationModel.initial(
    VideoPostInitialParams initialParams,
  )   : assert(
          initialParams.post.type == PostType.video,
          'In order to use VideoPostPage `post` param must be a video post',
        ),
        post = initialParams.post,
        comments = [],
        onPostUpdatedCallback = initialParams.onPostUpdated,
        reportId = initialParams.reportId,
        videoLastTappedAt = _videoTappedNeverDateTime,
        postsListInfoProvider = initialParams.postsListInfoProvider,
        isCurrentlyVisible = false,
        muted = initialParams.initiallyMuted || initialParams.mode == PostDetailsMode.preview,
        allowUnmute = initialParams.allowUnmute && initialParams.mode != PostDetailsMode.preview,
        showControls = initialParams.showControls && initialParams.mode != PostDetailsMode.preview,
        displayOptions = PostDisplayOptions(
          showTimestamp: initialParams.showTimestamp,
          showPostCommentBar: initialParams.showPostCommentBar,
          showPostSummaryBar: true,
          detailsMode: initialParams.mode,
          overlaySize: PostOverlaySize.fullscreen,
          commentsMode: CommentsMode.overlay,
          showPostSummaryBarAbovePost: initialParams.showPostSummaryBarAbovePost,
        ),
        fullScreenVideoDisplayOptions = PostDisplayOptions(
          showTimestamp: initialParams.showTimestamp,
          showPostCommentBar: initialParams.showPostCommentBar,
          showPostSummaryBar: true,
          detailsMode: initialParams.mode,
          overlaySize: PostOverlaySize.fullscreen,
          commentsMode: CommentsMode.drawer,
          showPostSummaryBarAbovePost: false,
        );

  /// Used for the copyWith method
  VideoPostPresentationModel._({
    required this.post,
    required this.comments,
    required this.reportId,
    required this.onPostUpdatedCallback,
    required this.videoLastTappedAt,
    required this.muted,
    required this.allowUnmute,
    required this.postsListInfoProvider,
    required this.isCurrentlyVisible,
    required this.showControls,
    required this.fullScreenVideoDisplayOptions,
    required this.displayOptions,
  });

  final Function(Post)? onPostUpdatedCallback;
  final PostsListInfoProvider? postsListInfoProvider;

  @override
  final Post post;

  @override
  final List<CommentPreview> comments;

  @override
  final Id reportId;

  @override
  final bool muted;

  /// see [VideoPostInitialParams.allowUnmute]
  @override
  final bool allowUnmute;

  @override
  final bool isCurrentlyVisible;

  @override
  final DateTime videoLastTappedAt;

  @override
  final bool showControls;

  @override
  final PostDisplayOptions fullScreenVideoDisplayOptions;

  @override
  final PostDisplayOptions displayOptions;

  bool get isPreviewMode => displayOptions.detailsMode == PostDetailsMode.preview;

  @override
  bool get pausable => !isPreviewMode;

  @override
  BasicPublicProfile get author => post.author;

  VideoPostContent get postContent => post.content as VideoPostContent;

  @override
  bool get showReportAction => fullScreenVideoDisplayOptions.detailsMode == PostDetailsMode.report;

  @override
  VideoUrl get videoUrl => postContent.videoUrl;

  @override
  ImageUrl get videoThumbnail => postContent.thumbnailUrl;

  @override
  Id get circleId => post.circle.id;

  VideoPostPresentationModel copyWith({
    Function(Post)? onPostUpdatedCallback,
    PostsListInfoProvider? postsListInfoProvider,
    Post? post,
    List<CommentPreview>? comments,
    Id? reportId,
    bool? muted,
    bool? allowUnmute,
    bool? isCurrentlyVisible,
    DateTime? videoLastTappedAt,
    bool? showControls,
    PostDisplayOptions? fullScreenVideoDisplayOptions,
    PostDisplayOptions? displayOptions,
  }) {
    return VideoPostPresentationModel._(
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      postsListInfoProvider: postsListInfoProvider ?? this.postsListInfoProvider,
      post: post ?? this.post,
      comments: comments ?? this.comments,
      reportId: reportId ?? this.reportId,
      muted: muted ?? this.muted,
      allowUnmute: allowUnmute ?? this.allowUnmute,
      isCurrentlyVisible: isCurrentlyVisible ?? this.isCurrentlyVisible,
      videoLastTappedAt: videoLastTappedAt ?? this.videoLastTappedAt,
      showControls: showControls ?? this.showControls,
      fullScreenVideoDisplayOptions: fullScreenVideoDisplayOptions ?? this.fullScreenVideoDisplayOptions,
      displayOptions: displayOptions ?? this.displayOptions,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class VideoPostViewModel {
  List<CommentPreview> get comments;

  bool get showReportAction;

  VideoUrl get videoUrl;

  Post get post;

  Id get reportId;

  DateTime get videoLastTappedAt;

  bool get muted;

  BasicPublicProfile get author;

  bool get isCurrentlyVisible;

  ImageUrl get videoThumbnail;

  bool get showControls;

  PostDisplayOptions get fullScreenVideoDisplayOptions;

  PostDisplayOptions get displayOptions;

  Id get circleId;

  bool get allowUnmute;

  bool get pausable;
}
