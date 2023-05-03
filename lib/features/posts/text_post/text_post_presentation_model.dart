import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class TextPostPresentationModel implements TextPostViewModel {
  /// Creates the initial state
  TextPostPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    TextPostInitialParams initialParams,
  )   : postAuthor = initialParams.post.author,
        comments = const [],
        expandedText = '',
        post = initialParams.post,
        onPostUpdatedCallback = initialParams.onPostUpdated,
        reportId = initialParams.reportId,
        displayOptions = PostDisplayOptions(
          commentsMode: CommentsMode.none,
          detailsMode: initialParams.mode,
          showPostCommentBar: initialParams.showPostCommentBar,
          showPostSummaryBar: false,
          showTimestamp: initialParams.showTimestamp,
          overlaySize: PostOverlaySize.fullscreen,
          showPostSummaryBarAbovePost: initialParams.showPostSummaryBarAbovePost,
        );

  /// Used for the copyWith method
  TextPostPresentationModel._({
    required this.postAuthor,
    required this.expandedText,
    required this.post,
    required this.comments,
    required this.reportId,
    required this.onPostUpdatedCallback,
    required this.displayOptions,
  });

  final Function(Post)? onPostUpdatedCallback;

  @override
  final String expandedText;

  @override
  final MinimalPublicProfile postAuthor;

  @override
  final Post post;

  @override
  final Id reportId;

  @override

  /// should be updated by PostOverlay only trough the PostOverlayMessenger callback
  final List<CommentPreview> comments;

  @override
  final PostDisplayOptions displayOptions;

  @override
  bool get showReportAction => displayOptions.detailsMode == PostDetailsMode.report;

  @override
  TextPostContent get postContent => post.content as TextPostContent;

  TextPostPresentationModel copyWith({
    Function(Post)? onPostUpdatedCallback,
    String? expandedText,
    MinimalPublicProfile? postAuthor,
    Post? post,
    Id? reportId,
    List<CommentPreview>? comments,
    PostDisplayOptions? displayOptions,
  }) {
    return TextPostPresentationModel._(
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      expandedText: expandedText ?? this.expandedText,
      postAuthor: postAuthor ?? this.postAuthor,
      post: post ?? this.post,
      reportId: reportId ?? this.reportId,
      comments: comments ?? this.comments,
      displayOptions: displayOptions ?? this.displayOptions,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class TextPostViewModel {
  List<CommentPreview> get comments;

  MinimalPublicProfile get postAuthor;

  bool get showReportAction;

  String get expandedText;

  TextPostContent get postContent;

  Post get post;

  Id get reportId;

  PostDisplayOptions get displayOptions;
}
