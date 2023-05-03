import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class TextPostFeedPresentationModel implements TextPostFeedViewModel {
  /// Creates the initial state
  TextPostFeedPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    TextPostFeedInitialParams initialParams,
    this.commentChatViewModel,
    this.postOverlayViewModel,
  )   : postAuthor = initialParams.post.author,
        post = initialParams.post,
        onPostUpdatedCallback = initialParams.onPostUpdated,
        mode = initialParams.mode,
        showTimestamp = initialParams.showTimestamp;

  /// Used for the copyWith method
  TextPostFeedPresentationModel._({
    required this.postAuthor,
    required this.post,
    required this.onPostUpdatedCallback,
    required this.commentChatViewModel,
    required this.postOverlayViewModel,
    required this.mode,
    required this.showTimestamp,
  });

  final Function(Post)? onPostUpdatedCallback;

  @override
  final MinimalPublicProfile postAuthor;

  @override
  final Post post;

  @override
  final CommentChatViewModel commentChatViewModel;

  @override
  final PostOverlayViewModel postOverlayViewModel;

  @override
  final PostDetailsMode mode;

  @override
  final bool showTimestamp;

  @override
  TextPostContent get postContent => post.content as TextPostContent;

  @override
  bool get showMoreCommentsVisible =>
      !commentChatViewModel.isLoadingInitialPageOfComments &&
      !commentChatViewModel.rootComment.children.isEmptyNoMorePage;

  @override
  bool get openCommentsChatVisible =>
      !commentChatViewModel.isLoadingInitialPageOfComments &&
      commentChatViewModel.rootComment.children.isEmptyNoMorePage;

  TextPostFeedPresentationModel copyWith({
    MinimalPublicProfile? postAuthor,
    Post? post,
    Function(Post)? onPostUpdatedCallback,
    CommentChatViewModel? commentChatViewModel,
    PostOverlayViewModel? postOverlayViewModel,
    PostDetailsMode? mode,
    bool? showTimestamp,
  }) {
    return TextPostFeedPresentationModel._(
      postAuthor: postAuthor ?? this.postAuthor,
      post: post ?? this.post,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      commentChatViewModel: commentChatViewModel ?? this.commentChatViewModel,
      postOverlayViewModel: postOverlayViewModel ?? this.postOverlayViewModel,
      mode: mode ?? this.mode,
      showTimestamp: showTimestamp ?? this.showTimestamp,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class TextPostFeedViewModel {
  MinimalPublicProfile get postAuthor;

  TextPostContent get postContent;

  Post get post;

  CommentChatViewModel get commentChatViewModel;

  PostOverlayViewModel get postOverlayViewModel;

  bool get showMoreCommentsVisible;

  bool get openCommentsChatVisible;

  PostDetailsMode get mode;

  bool get showTimestamp;
}
