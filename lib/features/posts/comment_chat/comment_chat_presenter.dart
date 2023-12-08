import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comments_focus_target.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/delete_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_pinned_comments_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_dislike_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_unlike_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/pin_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unpin_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/vote_in_poll_use_case.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
import 'package:picnic_app/utils/extensions/tree_extension.dart';

class CommentChatPresenter extends Cubit<CommentChatViewModel> with SubscriptionsMixin {
  CommentChatPresenter(
    super.model,
    this.navigator,
    this._likeDislikePostUseCase,
    this._unReactToPostUseCase,
    this._sharePostUseCase,
    this._likeDislikeCommentUseCase,
    this._unReactToCommentUseCase,
    this._getCommentsUseCase,
    this._createCommentUseCase,
    this._deleteCommentUseCase,
    this._getPinnedCommentUseCase,
    this._pinCommentUseCase,
    this._unpinCommentUseCase,
    this._joinCircleUseCase,
    this._savePostToCollectionUseCase,
    this._voteInPollUseCase,
    this._logAnalyticsEventUseCase,
    this._followUnfollowUseCase,
    this._userStore,
    this._deletePostsUseCase,
  ) {
    listenTo<PrivateProfile>(
      stream: _userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (privateProfile) {
        tryEmit(_model.copyWith(user: privateProfile));
      },
    );
  }

  final CommentChatNavigator navigator;

  static const _userStoreSubscription = "commentChatUserStoreSubscription";

  final LikeDislikePostUseCase _likeDislikePostUseCase;

  final UnreactToPostUseCase _unReactToPostUseCase;

  final SharePostUseCase _sharePostUseCase;

  final LikeUnlikeCommentUseCase _likeDislikeCommentUseCase;

  final UnreactToCommentUseCase _unReactToCommentUseCase;

  final GetCommentsUseCase _getCommentsUseCase;

  final CreateCommentUseCase _createCommentUseCase;

  final DeleteCommentUseCase _deleteCommentUseCase;

  final GetPinnedCommentsUseCase _getPinnedCommentUseCase;

  final PinCommentUseCase _pinCommentUseCase;

  final UnpinCommentUseCase _unpinCommentUseCase;

  final JoinCircleUseCase _joinCircleUseCase;

  final VoteInPollUseCase _voteInPollUseCase;

  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  final FollowUnfollowUserUseCase _followUnfollowUseCase;

  final SavePostToCollectionUseCase _savePostToCollectionUseCase;

  final UserStore _userStore;

  final DeletePostsUseCase _deletePostsUseCase;

  CommentChatPresentationModel get _model => state as CommentChatPresentationModel;

  Future<void> onInit() async {
    await loadComments();
  }

  void onTapLink(LinkUrl linkUrl) => navigator.openWebView(linkUrl.url);

  /// Should not handle post related actions here. They should be handled in post previews as separate MVPs
  /// TODO: https://picnic-app.atlassian.net/browse/GS-3908
  void onVoted(PicnicPollVote value) {
    late Id answerId;
    switch (value) {
      case PicnicPollVote.left:
        answerId = _model.pollContent.leftPollAnswer.id;
        break;
      case PicnicPollVote.right:
        answerId = _model.pollContent.rightPollAnswer.id;
        break;
    }
    _voteInPollUseCase
        .execute(
          VoteInPollInput(
            postId: _model.feedPost.id,
            answerId: answerId,
          ),
        )
        .observeStatusChanges(
          (result) => tryEmit(
            _model.copyWith(pollingResult: result),
          ),
        )
        .doOn(
          success: _onVotedSuccess,
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapTag() => _model.feedPost.circle.iJoined
      ? navigator.openCircleDetails(
          CircleDetailsInitialParams(
            circleId: _model.feedPost.circle.id,
          ),
        )
      : _joinCircleUseCase
          .execute(circle: _model.feedPost.circle)
          .doOn(
            success: (success) => tryEmit(
              _model.byUpdatingJoinedStatus(iJoined: true),
            ),
          )
          .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

  void onTapFollow() {
    final author = _model.feedPost.author;
    final previousFollow = author.iFollow;

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postFollowUserButton,
      ),
    );
    _emitAndNotify(_model.byUpdatingAuthorWithFollow(follow: true));
    _followUnfollowUseCase
        .execute(
          userId: author.id,
          follow: true,
        ) //
        .doOn(
          success: (success) => _emitAndNotify(_model.byUpdatingAuthorWithFollow(follow: true)),
        )
        .doOn(
      fail: (fail) {
        _emitAndNotify(_model.byUpdatingAuthorWithFollow(follow: previousFollow));
        navigator.showError(fail.displayableFailure());
      },
    );
  }

  void onTapBookmark() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postBookmarkButton,
      ),
    );

    final previousState = _model.feedPost.context.saved;

    void emitStatus({required bool saved}) {
      _emitAndNotify(_model.byUpdatingSavedStatus(saved: saved));
      _model.onPostUpdatedCallback?.call(_model.feedPost);
    }

    emitStatus(saved: !previousState);

    _savePostToCollectionUseCase
        .execute(
          input: SavePostInput(
            postId: _model.feedPost.id,
            save: !previousState,
          ),
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(savingPostResult: result)),
        )
        .doOn(
          success: (post) {
            emitStatus(saved: post.context.saved);
          },
          fail: (fail) => emitStatus(saved: previousState),
        );
  }

  void onTapOptions() => navigator.onTapMore(
        onTapDeletePost: _model.canDeletePost
            ? () {
                navigator.close();
                _onTapDeletePost();
              }
            : null,
        onTapReport: _model.canReportPost ? onTapReportPost : null,
      );

  void onTapReportPost() => navigator.openReportForm(
        ReportFormInitialParams(
          entityId: _model.feedPost.id,
          circleId: _model.feedPost.circle.id,
          reportEntityType: ReportEntityType.post,
          contentAuthorId: _model.feedPost.author.id,
        ),
      );

  Future<void> onTapLikeComment(TreeComment comment) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCommentsLikeButton,
        targetValue: (!comment.iLiked).toString(),
      ),
    );
    await _executeLikeReactUnReactCommentUseCase(comment);
  }

  Future<void> onTapDislikeComment(TreeComment comment) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCommentsDislikeButton,
        targetValue: (!comment.iDisliked).toString(),
      ),
    );
    await _executeDislikeReactUnReactCommentUseCase(comment);
  }

  void onTapReply(TreeComment comment) {
    tryEmit(
      _model.copyWith(
        replyingComment: comment,
      ),
    );
  }

  void onTapCancelReply() {
    tryEmit(
      _model.copyWith(
        replyingComment: const TreeComment.none(),
      ),
    );
  }

  Future<void> onLoadMore(TreeComment comment) async {
    if (_model.commentsResult.isPending() || !_model.commentsRoot.containsNode(comment)) {
      return;
    }
    await _loadMoreComments(comment);
  }

  /// Handles tap on send button
  /// Returns `true` if the handling was successful, `false` otherwise
  bool onTapSend(String text) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCommentsSendCommentButton,
      ),
    );
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return false;
    }

    _createCommentUseCase
        .execute(
          postId: _model.postId,
          text: trimmedText,
          parentCommentId: _model.replyingComment.id,
          postAuthorId: _model.feedPost.author.id,
        )
        .doOn(success: (comment) => _handleCreateCommentEvent(comment))
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

    return true;
  }

  void onTapProfile(Id userId) {
    navigator.openProfile(userId: userId);
  }

  void onTap(TreeComment comment) {
    tryEmit(
      _model.byInvertingCollapsedComment(comment),
    );
  }

  void onTapMore(TreeComment comment) {
    navigator.openCommentChat(
      CommentChatInitialParams(
        post: _model.feedPost,
        nestedComment: comment,
      ),
    );
  }

  void onDoubleTap(TreeComment comment) {
    if (!comment.iLiked) {
      onTapLikeComment(comment);
    }
  }

  //ignore: long-method
  void onLongPress(TreeComment comment) {
    navigator.showCommentActionBottomSheet(
      comment: comment,
      onTapReply: () {
        navigator.close();
        onTapReply(comment);
      },
      onTapReport: () {
        navigator.close();
        _onReportComment(comment);
      },
      onTapLike: () {
        navigator.close();
        onTapLikeComment(comment);
      },
      onTapDelete: !comment.isDeleted &&
              (_model.feedPost.circle.permissions.canManageComments || comment.author.id == _model.user.id)
          ? () {
              navigator.close();
              _onDeleteComment(comment);
            }
          : null,
      onTapPin: _model.isPinUnpinAllowed && !comment.isPinned && _model.isFirstLevelComment(comment)
          ? () {
              navigator.close();
              onPinComment(comment);
            }
          : null,
      onTapUnpin: _model.isPinUnpinAllowed && comment.isPinned
          ? () {
              navigator.close();
              onUnpinComment(comment);
            }
          : null,
      onTapShare: () => navigator.shareText(text: comment.text),
      onTapClose: navigator.close,
      onTapShareCommentItem: onTapShareCommentItem,
    );
  }

  Future<void> onTapReportActions() async {
    final reportedComment = _model.reportedComment!;
    final commentAuthor = reportedComment.author;
    final reportType = await navigator.openReportedContent(
      ReportedContentInitialParams(
        author: BasicPublicProfile(
          id: commentAuthor.id,
          username: commentAuthor.username,
          profileImageUrl: commentAuthor.profileImageUrl,
          iFollow: false,
          isVerified: commentAuthor.isVerified,
        ),
        circleId: _model.feedPost.circle.id,
        reportId: _model.reportId,
        reportType: ReportEntityType.comment,
      ),
    );
    if (reportType != null) {
      await loadComments(fromScratch: true);
    }
  }

  Future<void> loadComments({bool fromScratch = false}) async {
    if (fromScratch) {
      tryEmit(_model.copyWith(commentsRoot: const TreeComment.empty()));
    } else if (_model.commentsResult.isPending()) {
      return;
    }
    await _getPinnedCommentUseCase //
        .execute(post: _model.feedPost)
        .doOn(
          success: (pinnedComments) => tryEmit(_model.copyWith(pinnedComments: pinnedComments)),
        );
    await _getCommentsUseCase
        .execute(
          post: _model.feedPost,
          parentCommentId: _model.commentsRoot.parent.id,
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(commentsResult: result)),
        )
        .doOnSuccessWait(
      (commentsRoot) async {
        if (_model.commentsRoot.hasParent) {
          final children = commentsRoot.children.byRemovingWhere((child) => child.id != _model.commentsRoot.id);
          tryEmit(_model.copyWith(commentsRoot: _model.commentsRoot.parent.copyWithChildren(children)));
        } else {
          final scrollIndex = commentsRoot.children.indexWhere((c) => c.id == _model.initialComment.id);
          tryEmit(_model.copyWith(commentsRoot: commentsRoot, scrollIndex: scrollIndex != -1 ? scrollIndex : null));
        }
      },
    ).doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<void> onPinComment(TreeComment comment) async {
    if (_model.pinnedComments.isNotEmpty) {
      final pinnedComment = _model.pinnedComments.firstOrNull;
      if (pinnedComment == null) {
        await pinComment(comment);
      } else {
        navigator.showChangingPinnedComment(
          comment: _model.pinnedComments.first,
          onTapChange: () async => {
            navigator.close(),
            await onUnpinComment(pinnedComment),
            await pinComment(comment),
            await loadComments(),
          },
          onTapCancel: navigator.close,
          onTapShare: onTapShare,
          onTapShareCommentItem: onTapShareCommentItem,
        );
      }
    } else {
      await pinComment(comment);
    }
  }

  Future<void> pinComment(TreeComment comment) async {
    await _pinCommentUseCase
        .execute(commentId: comment.id)
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()))
        .doOn(
          success: (_) => tryEmit(
            _model.byAppendingPinnedComment(
              comment.copyWith(isPinned: true),
            ),
          ),
        );
  }

  void onTapShareCommentItem(String text) {
    navigator.shareText(text: text);
  }

  void onTapShare() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postShareButton,
      ),
    );
    navigator.shareText(text: _model.feedPost.shareLink);

    _sharePostUseCase
        .execute(
          postId: _model.feedPost.id,
        )
        .doOn(
          success: (_) => _emitAndNotify(_model.byUpdatingShareStatus()),
        )
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<void> onUnpinComment(TreeComment comment) async {
    await _unpinCommentUseCase
        .execute(commentId: comment.id)
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()))
        .doOn(
      success: (_) {
        tryEmit(
          _model.byRemovingPinnedComment(comment),
        );
        loadComments(fromScratch: true);
      },
    );
  }

  Future<void> onTapLikePost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postLikeButton,
        targetValue: (!_model.feedPost.iLiked).toString(),
      ),
    );
    await _executeLikeReactUnReactPostUseCase();
  }

  Future<void> onTapDislikePost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postDislikeButton,
        targetValue: (!_model.feedPost.iDisliked).toString(),
      ),
    );
    await _executeDislikeReactUnReactPostUseCase();
  }

  Future<void> _executeLikeReactUnReactPostUseCase() async {
    final initialReaction = _model.feedPost.context.reaction;
    final iLikedPreviously = _model.feedPost.iLiked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iLikedPreviously ? _model.feedPost.byUnReactingToPost() : _model.feedPost.byLikingPost();
    _emitAndNotify(_model.copyWith(feedPost: newPost));

    if (iLikedPreviously) {
      await _unReactToPostUseCase.execute(postId: _model.feedPost.id).doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.feedPost, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikePostUseCase
          .execute(
        id: _model.feedPost.id,
        likeDislikeReaction: LikeDislikeReaction.like,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.feedPost, initialReaction: initialReaction);
        },
      );
    }
  }

  Future<void> _executeDislikeReactUnReactPostUseCase() async {
    final initialReaction = _model.feedPost.context.reaction;
    final iDislikedPreviously = _model.feedPost.iDisliked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iDislikedPreviously ? _model.feedPost.byUnReactingToPost() : _model.feedPost.byDislikingPost();
    _emitAndNotify(_model.copyWith(feedPost: newPost));

    if (iDislikedPreviously) {
      await _unReactToPostUseCase.execute(postId: _model.feedPost.id).doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.feedPost, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikePostUseCase
          .execute(
        id: _model.feedPost.id,
        likeDislikeReaction: LikeDislikeReaction.dislike,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.feedPost, initialReaction: initialReaction);
        },
      );
    }
  }

  //ignore: long-method
  Future<void> _executeLikeReactUnReactCommentUseCase(TreeComment comment) async {
    final initialReaction = comment.myReaction;
    final iLikedPreviously = comment.iLiked;

    //this updates the UI immediately on tap
    late TreeComment newComment;
    newComment = iLikedPreviously ? comment.byUnReactingToComment() : comment.byLikingComment();

    final updatedCommentsTree = _model.commentsRoot.replaceNode(
      comment,
      newComment,
    );

    tryEmit(
      _model.copyWith(
        commentsRoot: updatedCommentsTree,
      ),
    );

    if (iLikedPreviously) {
      await _unReactToCommentUseCase.execute(comment.id).doOn(
        fail: (fail) {
          _reEmitInitialCommentReaction(comment: comment, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikeCommentUseCase
          .execute(
        commentId: comment.id,
        likeDislikeReaction: LikeDislikeReaction.like,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialCommentReaction(comment: comment, initialReaction: initialReaction);
        },
      );
    }
  }

  //ignore: long-method
  Future<void> _executeDislikeReactUnReactCommentUseCase(TreeComment comment) async {
    final initialReaction = comment.myReaction;
    final iDislikedPreviously = comment.iDisliked;

    //this updates the UI immediately on tap
    late TreeComment newComment;
    newComment = iDislikedPreviously ? comment.byUnReactingToComment() : comment.byDislikingComment();
    final updatedCommentsTree = _model.commentsRoot.replaceNode(
      comment,
      newComment,
    );

    tryEmit(
      _model.copyWith(
        commentsRoot: updatedCommentsTree,
      ),
    );

    if (iDislikedPreviously) {
      await _unReactToCommentUseCase.execute(comment.id).doOn(
        fail: (fail) {
          _reEmitInitialCommentReaction(comment: comment, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikeCommentUseCase
          .execute(
        commentId: comment.id,
        likeDislikeReaction: LikeDislikeReaction.dislike,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.feedPost, initialReaction: initialReaction);
        },
      );
    }
  }

  void _reEmitInitialPostReaction({
    required Post post,
    required LikeDislikeReaction initialReaction,
  }) {
    late Post newPost;
    switch (initialReaction) {
      case LikeDislikeReaction.like:
        newPost = post.byLikingPost();
        break;
      case LikeDislikeReaction.dislike:
        newPost = post.byDislikingPost();
        break;
      case LikeDislikeReaction.noReaction:
        newPost = post.byUnReactingToPost();
        break;
    }
    _emitAndNotify(_model.copyWith(feedPost: newPost));
  }

  void _reEmitInitialCommentReaction({
    required TreeComment comment,
    required LikeDislikeReaction initialReaction,
  }) {
    late TreeComment newComment;
    switch (initialReaction) {
      case LikeDislikeReaction.like:
        newComment = comment.byLikingComment();
        break;
      case LikeDislikeReaction.dislike:
        newComment = comment.byDislikingComment();
        break;
      case LikeDislikeReaction.noReaction:
        newComment = comment.byUnReactingToComment();
        break;
    }
    final updatedCommentsTree = _model.commentsRoot.replaceNode(
      comment,
      newComment,
    );

    tryEmit(
      _model.copyWith(
        commentsRoot: updatedCommentsTree,
      ),
    );
  }

  void _emitAndNotify(CommentChatPresentationModel state) {
    final oldPost = _model.feedPost;
    tryEmit(state);
    final newPost = _model.feedPost;
    if (oldPost != newPost) {
      _model.onPostUpdatedCallback?.call(newPost);
    }
  }

  void _onTapDeletePost() {
    navigator.close();
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.deletePost,
      message: appLocalizations.deletePostConfirmationMessage,
      primaryAction: ConfirmationAction(
        roundedButton: true,
        title: appLocalizations.deletePost,
        action: () {
          navigator.close();
          _deletePostsUseCase.execute(postIds: [_model.feedPost.id]).doOn(
            success: (success) => navigator.closeWithResult(
              const PostRouteResult(postRemoved: true),
            ),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }

  void _onReportComment(TreeComment comment) => navigator.openReportForm(
        ReportFormInitialParams(
          circleId: _model.feedPost.circle.id,
          entityId: comment.id,
          reportEntityType: ReportEntityType.comment,
          contentAuthorId: comment.author.id,
        ),
      );

  void _onDeleteComment(TreeComment comment) => _deleteCommentUseCase
          .execute(commentId: comment.id)
          .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()))
          .doOn(
        success: (_) {
          if (_model.pinnedComments.any((element) => element.id == comment.id)) {
            tryEmit(_model.byRemovingPinnedComment(comment));
            loadComments(fromScratch: true);
          } else {
            tryEmit(_model.byDeletingComment(comment));
          }
        },
      );

  // ignore: long-method
  Future<void> _handleCreateCommentEvent(TreeComment comment) async {
    final parentComment = _model.replyingComment != const TreeComment.none() //
        ? _model.replyingComment
        : _model.commentsRoot;

    final updatedCommentsTree = _model.commentsRoot
        .byAddingComment(newComment: comment, parentCommentId: parentComment.id)
        .normalizeConnections();

    final scrollToComment = updatedCommentsTree.firstWhereOrNull((e) => e.id == comment.id);

    tryEmit(
      _model.copyWith(
        focusTarget: scrollToComment == null
            ? CommentsFocusTargetViewportEnd() //
            : CommentsFocusTargetComment(scrollToComment),
        replyingComment: const TreeComment.none(),
        commentsRoot: updatedCommentsTree,
        feedPost: _model.feedPost.copyWith(
          contentStats: _model.feedPost.contentStats.copyWith(comments: _model.feedPost.contentStats.comments + 1),
        ),
      ),
    );
  }

  Future<Either<GetCommentsFailure, TreeComment>> _loadMoreComments(TreeComment parent) => _getCommentsUseCase
      .execute(
        post: _model.feedPost,
        parentCommentId: parent.id,
        cursor: parent.children.nextPageCursor(),
      )
      .observeStatusChanges((commentsResult) => tryEmit(_model.copyWith(commentsResult: commentsResult)))
      .doOn(
        success: (newComments) => tryEmit(
          _model.byAddingMoreComments(
            parentCommentId: parent.id,
            newComments: newComments,
          ),
        ),
      )
      .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

  void _onVotedSuccess(Post post) {
    tryEmit(
      _model.copyWith(
        feedPost: _model.feedPost.copyWith(
          content: post.content,
        ),
      ),
    );
    _model.onPostUpdatedCallback?.call(_model.feedPost);

    navigator.showFxEffect(LottieFxEffect.glitter());
  }
}

extension ReplyCountIncreaseExtension on TreeComment {
  TreeComment byAddingComment({
    required TreeComment newComment,
    required Id parentCommentId,
  }) {
    if (this.id == parentCommentId) {
      return copyWith(
        children: children.byAddingFirst(element: newComment),
        repliesCount: repliesCount + 1,
      );
    }

    var didChildrenReplyCountIncreased = false;
    final newChildren = children.mapItems((child) {
      final newChild = child.byAddingComment(
        newComment: newComment,
        parentCommentId: parentCommentId,
      );
      if (newChild.repliesCount != child.repliesCount) {
        didChildrenReplyCountIncreased = true;
      }
      return newChild;
    });

    return copyWith(
      children: newChildren,
      repliesCount: didChildrenReplyCountIncreased ? repliesCount + 1 : repliesCount,
    );
  }
}
