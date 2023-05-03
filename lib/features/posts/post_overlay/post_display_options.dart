import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';

class PostDisplayOptions extends Equatable {
  const PostDisplayOptions({
    required this.showTimestamp,
    required this.showPostCommentBar,
    required this.showPostSummaryBar,
    required this.overlaySize,
    required this.commentsMode,
    required this.detailsMode,
    required this.showPostSummaryBarAbovePost,
  });

  const PostDisplayOptions.empty()
      : showTimestamp = false,
        showPostSummaryBar = false,
        showPostCommentBar = false,
        showPostSummaryBarAbovePost = false,
        overlaySize = PostOverlaySize.fullscreen,
        commentsMode = CommentsMode.none,
        detailsMode = PostDetailsMode.feed;

  final bool showTimestamp;
  final bool showPostCommentBar;
  final bool showPostSummaryBar;
  final bool showPostSummaryBarAbovePost;
  final PostOverlaySize overlaySize;
  final CommentsMode commentsMode;
  final PostDetailsMode detailsMode;

  @override
  List<Object> get props => [
        showTimestamp,
        showPostCommentBar,
        showPostSummaryBar,
        showPostSummaryBarAbovePost,
        overlaySize,
        commentsMode,
        detailsMode,
      ];

  PostDisplayOptions copyWith({
    bool? showTimestamp,
    bool? showPostCommentBar,
    bool? showPostSummaryBar,
    bool? showPostSummaryBarAbovePost,
    PostOverlaySize? overlaySize,
    CommentsMode? commentsMode,
    PostDetailsMode? detailsMode,
  }) {
    return PostDisplayOptions(
      showTimestamp: showTimestamp ?? this.showTimestamp,
      showPostCommentBar: showPostCommentBar ?? this.showPostCommentBar,
      showPostSummaryBar: showPostSummaryBar ?? this.showPostSummaryBar,
      showPostSummaryBarAbovePost: showPostSummaryBarAbovePost ?? this.showPostSummaryBarAbovePost,
      overlaySize: overlaySize ?? this.overlaySize,
      commentsMode: commentsMode ?? this.commentsMode,
      detailsMode: detailsMode ?? this.detailsMode,
    );
  }
}
