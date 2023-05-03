import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/link_post/link_post_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LinkPostPresentationModel implements LinkPostViewModel {
  /// Creates the initial state
  LinkPostPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LinkPostInitialParams initialParams,
  )   : comments = const [],
        post = initialParams.post,
        onPostUpdatedCallback = initialParams.onPostUpdated,
        reportId = initialParams.reportId,
        displayOptions = PostDisplayOptions(
          showTimestamp: initialParams.showTimestamp,
          showPostCommentBar: initialParams.showPostCommentBar,
          showPostSummaryBar: false,
          detailsMode: initialParams.mode,
          overlaySize: initialParams.overlaySize,
          commentsMode: CommentsMode.none,
          showPostSummaryBarAbovePost: initialParams.showPostSummaryBarAbovePost,
        );

  /// Used for the copyWith method
  LinkPostPresentationModel._({
    required this.post,
    required this.comments,
    required this.reportId,
    required this.onPostUpdatedCallback,
    required this.displayOptions,
  });

  final Function(Post)? onPostUpdatedCallback;

  @override
  final PostDisplayOptions displayOptions;

  @override
  final Id reportId;

  @override
  final Post post;

  @override
  final List<CommentPreview> comments;

  @override
  BasicPublicProfile get author => post.author;

  @override
  bool get showReportAction => displayOptions.detailsMode == PostDetailsMode.report;

  @override
  LinkPostContent get linkContent => post.content as LinkPostContent;

  LinkPostPresentationModel copyWith({
    Function(Post)? onPostUpdatedCallback,
    PostDisplayOptions? displayOptions,
    Id? reportId,
    Post? post,
    List<CommentPreview>? comments,
  }) {
    return LinkPostPresentationModel._(
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      displayOptions: displayOptions ?? this.displayOptions,
      reportId: reportId ?? this.reportId,
      post: post ?? this.post,
      comments: comments ?? this.comments,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LinkPostViewModel {
  List<CommentPreview> get comments;

  BasicPublicProfile get author;

  Post get post;

  Id get reportId;

  bool get showReportAction;

  LinkPostContent get linkContent;

  PostDisplayOptions get displayOptions;
}
