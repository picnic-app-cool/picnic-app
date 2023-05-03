import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ImagePostPresentationModel implements ImagePostViewModel {
  /// Creates the initial state
  ImagePostPresentationModel.initial(
    ImagePostInitialParams initialParams,
  )   : post = initialParams.post,
        comments = [],
        onPostUpdatedCallback = initialParams.onPostUpdated,
        reportId = initialParams.reportId,
        displayOptions = PostDisplayOptions(
          showTimestamp: initialParams.showTimestamp,
          showPostCommentBar: initialParams.showPostCommentBar,
          showPostSummaryBar: true,
          detailsMode: initialParams.mode,
          overlaySize: initialParams.overlaySize,
          commentsMode: CommentsMode.overlay,
          showPostSummaryBarAbovePost: initialParams.showPostSummaryBarAbovePost,
        );

  /// Used for the copyWith method
  ImagePostPresentationModel._({
    required this.post,
    required this.comments,
    required this.reportId,
    required this.onPostUpdatedCallback,
    required this.displayOptions,
  });

  final Function(Post)? onPostUpdatedCallback;

  @override
  final Id reportId;

  @override
  final Post post;

  @override
  final List<CommentPreview> comments;

  @override
  final PostDisplayOptions displayOptions;

  @override
  ImagePostContent get imageContent => post.content as ImagePostContent;

  @override
  BasicPublicProfile get author => post.author;

  @override
  bool get showReportAction => displayOptions.detailsMode == PostDetailsMode.report;

  ImagePostPresentationModel copyWith({
    Function(Post)? onPostUpdatedCallback,
    Id? reportId,
    Post? post,
    List<CommentPreview>? comments,
    PostDisplayOptions? displayOptions,
  }) {
    return ImagePostPresentationModel._(
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      reportId: reportId ?? this.reportId,
      post: post ?? this.post,
      comments: comments ?? this.comments,
      displayOptions: displayOptions ?? this.displayOptions,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ImagePostViewModel {
  List<CommentPreview> get comments;

  BasicPublicProfile get author;

  Post get post;

  Id get reportId;

  bool get showReportAction;

  ImagePostContent get imageContent;

  PostDisplayOptions get displayOptions;
}
