import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comments_focus_target.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_failure.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';
import 'package:picnic_app/utils/extensions/tree_extension.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CommentChatPresentationModel implements CommentChatViewModel {
  /// Creates the initial state
  CommentChatPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CommentChatInitialParams initialParams,
    FeatureFlagsStore featureFlags,
    UserStore userStore,
  )   : feedPost = initialParams.post,
        commentsRoot = initialParams.nestedComment,
        pinnedComments = [],
        commentsResult = const FutureResult.empty(),
        focusTarget = const CommentsFocusTargetNone(),
        replyingComment = const TreeComment.none(),
        user = userStore.privateProfile,
        featureFlags = featureFlags.featureFlags,
        pollingResult = const FutureResult.empty(),
        savingPostResult = const FutureResult.empty(),
        onPostUpdatedCallback = initialParams.onPostUpdated,
        reportedComment = initialParams.reportedComment,
        reportId = initialParams.reportId,
        showAppBar = initialParams.showAppBar,
        showPostSummary = initialParams.showPostPreview,
        shouldBeDisposed = initialParams.shouldBeDisposed,
        initialComment = initialParams.initialComment,
        collapsedCommentIds = [],
        scrollIndex = 0;

  /// Used for the copyWith method
  CommentChatPresentationModel._({
    required this.feedPost,
    required this.commentsRoot,
    required this.pinnedComments,
    required this.commentsResult,
    required this.focusTarget,
    required this.replyingComment,
    required this.user,
    required this.featureFlags,
    required this.pollingResult,
    required this.savingPostResult,
    required this.onPostUpdatedCallback,
    required this.reportedComment,
    required this.reportId,
    required this.showAppBar,
    required this.showPostSummary,
    required this.shouldBeDisposed,
    required this.initialComment,
    required this.collapsedCommentIds,
    required this.scrollIndex,
  });

  final FutureResult<Either<VoteInPollFailure, Post>> pollingResult;
  final Function(Post)? onPostUpdatedCallback;

  @override
  final Post feedPost;

  final TreeComment commentsRoot;

  final List<TreeComment> pinnedComments;

  final FutureResult<Either<GetCommentsFailure, TreeComment>> commentsResult;

  @override
  final CommentsFocusTarget focusTarget;

  @override
  final TreeComment replyingComment;

  @override
  final PrivateProfile user;

  @override
  final TreeComment? reportedComment;

  @override
  final bool showAppBar;

  @override
  final bool showPostSummary;

  @override
  final bool shouldBeDisposed;

  @override
  final TreeComment initialComment;

  @override
  final List<Id> collapsedCommentIds;

  @override
  final int scrollIndex;

  final Id reportId;

  final FeatureFlags featureFlags;

  final FutureResult<Either<SavePostToCollectionFailure, Post>> savingPostResult;

  bool get isPinUnpinAllowed {
    final circleRole = feedPost.circle.circleRole;
    return circleRole == CircleRole.moderator || circleRole == CircleRole.director;
  }

  @override
  TreeComment get rootComment {
    var children = commentsRoot.children.byRemovingWhere(
      (comment) => pinnedComments.any(
        (pinnedComment) => pinnedComment.id == comment.id,
      ),
    );
    children = children.copyWith(items: [...pinnedComments, ...children.items].unmodifiable);
    return commentsRoot.copyWith(children: children);
  }

  @override
  bool get isLoadingInitialPageOfComments => commentsRoot == const TreeComment.empty() && commentsResult.isPending();

  @override
  Id get postId => feedPost.id;

  @override
  bool get shouldAttachmentBeVisible => featureFlags[FeatureFlagType.commentAttachmentEnabled];

  @override
  bool get shouldInstantCommandsBeVisible => featureFlags[FeatureFlagType.commentInstantCommandsEnabled];

  @override
  bool get postSaved => feedPost.context.saved;

  @override
  bool get showReportAction => reportedComment != null;

  @override
  PollPostContent get pollContent =>
      feedPost.type == PostType.poll ? feedPost.content as PollPostContent : const PollPostContent.empty();

  @override
  PicnicPollVote? get vote => pollContent.votedAnswerId.isNone
      ? null
      : (pollContent.votedAnswerId == pollContent.rightPollAnswer.id ? PicnicPollVote.right : PicnicPollVote.left);

  @override
  bool get isPolling => pollingResult.isPending();

  @override
  bool get isSavingPost => savingPostResult.isPending();

  @override
  bool get isReplying => replyingComment != const TreeComment.empty();

  bool isFirstLevelComment(TreeComment comment) => rootComment.children.contains(comment);

  CommentChatPresentationModel byAddingMoreComments({
    required Id parentCommentId,
    required TreeComment newComments,
  }) {
    final parentComment = commentsRoot.firstWhereOrNull((e) => e.id == parentCommentId);
    if (parentComment == null) {
      return this;
    }
    return copyWith(
      commentsRoot: commentsRoot.replaceNode(
        parentComment,
        parentComment.copyWithChildren(
          parentComment.children + newComments.children,
        ),
      ),
    );
  }

  CommentChatPresentationModel byDeletingComment(TreeComment comment) {
    var newCommentsRoot = commentsRoot;
    try {
      newCommentsRoot = commentsRoot.replaceNode(
        comment.parent,
        comment.parent.copyWithChildren(
          comment.parent.children.byUpdatingItem(
            update: (e) => e.copyWith(isDeleted: true),
            itemFinder: (e) => e.id == comment.id,
          ),
        ),
      );
    } catch (e) {
      doNothing();
    }
    return copyWith(
      commentsRoot: newCommentsRoot,
      pinnedComments: [...pinnedComments]..removeWhere((e) => e.id == comment.id),
    );
  }

  CommentChatPresentationModel byInvertingCollapsedComment(TreeComment comment) {
    final _collapsedCommentIds = [...collapsedCommentIds];
    final commentId = comment.id;
    if (_collapsedCommentIds.contains(commentId)) {
      collapsedCommentIds.remove(commentId);
    } else if (comment.children.isNotEmpty) {
      collapsedCommentIds.add(commentId);
    }
    return copyWith(collapsedCommentIds: collapsedCommentIds);
  }

  CommentChatPresentationModel byAppendingPinnedComment(TreeComment comment) {
    if (pinnedComments.any((e) => e.id == comment.id)) {
      return this;
    }
    final newPinnedComments = [...pinnedComments];
    if (newPinnedComments.isNotEmpty) {
      newPinnedComments.removeLast();
    }
    return copyWith(
      pinnedComments: newPinnedComments..add(comment),
    );
  }

  CommentChatPresentationModel byRemovingPinnedComment(TreeComment comment) {
    return copyWith(
      pinnedComments: [...pinnedComments]..removeWhere((e) => e.id == comment.id),
    );
  }

  CommentChatPresentationModel byUpdatingJoinedStatus({required bool iJoined}) => copyWith(
        feedPost: feedPost.copyWith(
          circle: feedPost.circle.copyWith(iJoined: iJoined),
        ),
      );

  CommentChatPresentationModel byUpdatingSavedStatus({required bool saved}) => copyWith(
        feedPost: feedPost.copyWith(context: feedPost.context.copyWith(saved: saved)),
      );

  CommentChatPresentationModel byUpdatingAuthorWithFollow({required bool follow}) {
    return copyWith(
      feedPost: feedPost.copyWith(
        author: feedPost.author.copyWith(iFollow: follow),
      ),
    );
  }

  CommentChatPresentationModel byUpdatingShareStatus() {
    return copyWith(
      feedPost: feedPost.byIncrementingShareCount(),
    );
  }

  CommentChatPresentationModel copyWith({
    Post? feedPost,
    TreeComment? commentsRoot,
    List<TreeComment>? pinnedComments,
    TreeComment? nestedRootComment,
    FutureResult<Either<GetCommentsFailure, TreeComment>>? commentsResult,
    CommentsFocusTarget? focusTarget,
    TreeComment? replyingComment,
    PrivateProfile? user,
    FeatureFlags? featureFlags,
    FutureResult<Either<VoteInPollFailure, Post>>? pollingResult,
    FutureResult<Either<SavePostToCollectionFailure, Post>>? savingPostResult,
    Function(Post)? onPostUpdatedCallback,
    TreeComment? reportedComment,
    Id? reportId,
    bool? showAppBar,
    bool? showPostSummary,
    bool? shouldBeDisposed,
    TreeComment? initialComment,
    List<Id>? collapsedCommentIds,
    int? scrollIndex,
  }) {
    return CommentChatPresentationModel._(
      feedPost: feedPost ?? this.feedPost,
      commentsRoot: commentsRoot ?? this.commentsRoot,
      pinnedComments: pinnedComments ?? this.pinnedComments,
      commentsResult: commentsResult ?? this.commentsResult,
      focusTarget: focusTarget ?? this.focusTarget,
      replyingComment: replyingComment ?? this.replyingComment,
      user: user ?? this.user,
      featureFlags: featureFlags ?? this.featureFlags,
      pollingResult: pollingResult ?? this.pollingResult,
      savingPostResult: savingPostResult ?? this.savingPostResult,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      reportedComment: reportedComment ?? this.reportedComment,
      reportId: reportId ?? this.reportId,
      showAppBar: showAppBar ?? this.showAppBar,
      showPostSummary: showPostSummary ?? this.showPostSummary,
      shouldBeDisposed: shouldBeDisposed ?? this.shouldBeDisposed,
      initialComment: initialComment ?? this.initialComment,
      collapsedCommentIds: collapsedCommentIds ?? this.collapsedCommentIds,
      scrollIndex: scrollIndex ?? this.scrollIndex,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CommentChatViewModel {
  CommentsFocusTarget get focusTarget;

  TreeComment get rootComment;

  Post get feedPost;

  bool get isLoadingInitialPageOfComments;

  Id get postId;

  TreeComment get replyingComment;

  bool get isReplying;

  PrivateProfile get user;

  bool get shouldAttachmentBeVisible;

  bool get shouldInstantCommandsBeVisible;

  bool get postSaved;

  PollPostContent get pollContent;

  PicnicPollVote? get vote;

  bool get isPolling;

  bool get isSavingPost;

  bool get showReportAction;

  TreeComment? get reportedComment;

  bool get showAppBar;

  bool get showPostSummary;

  bool get shouldBeDisposed;

  TreeComment get initialComment;

  List<Id> get collapsedCommentIds;

  int get scrollIndex;
}
