import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/use_cases/delete_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_preview_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_dislike_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_unlike_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_post_use_case.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_navigator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/saved_post_snackbar.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';

class PostOverlayPresenter extends Cubit<PostOverlayViewModel> {
  PostOverlayPresenter(
    super.model,
    this.navigator,
    this._likeDislikePostUseCase,
    this._likeDislikeCommentUseCase,
    this._savePostToCollectionUseCase,
    this._followUnfollowUseCase,
    this._joinCircleUseCase,
    this._getCommentsPreviewUseCase,
    this._deleteCommentUseCase,
    this._getPostUseCase,
    this._logAnalyticsEventUseCase,
    this._currentTimeProvider,
    this._sharePostUseCase,
    this._unReactToPostUseCase,
    this._unReactToCommentUseCase,
  );

  final PostOverlayNavigator navigator;
  final LikeDislikePostUseCase _likeDislikePostUseCase;
  final LikeUnlikeCommentUseCase _likeDislikeCommentUseCase;
  final SavePostToCollectionUseCase _savePostToCollectionUseCase;
  final FollowUnfollowUserUseCase _followUnfollowUseCase;
  final JoinCircleUseCase _joinCircleUseCase;
  final GetCommentsPreviewUseCase _getCommentsPreviewUseCase;
  final DeleteCommentUseCase _deleteCommentUseCase;
  final GetPostUseCase _getPostUseCase;
  final SharePostUseCase _sharePostUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final CurrentTimeProvider _currentTimeProvider;
  final UnreactToPostUseCase _unReactToPostUseCase;
  final UnreactToCommentUseCase _unReactToCommentUseCase;

  PostOverlayPresentationModel get _model => state as PostOverlayPresentationModel;

  Future<void> onInit() async {
    if (_model.displayOptions.detailsMode != PostDetailsMode.preview) {
      return _refreshComments();
    }
  }

  Future<void> onTapLikeReactUnReactComment(CommentPreview comment) async {
    final initialReaction = comment.myReaction;
    final iLikedPreviously = comment.iLiked;

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCommentsLikeButton,
        targetValue: (!iLikedPreviously).toString(),
      ),
    );

    //this updates the UI immediately on tap
    late CommentPreview newComment;
    newComment = iLikedPreviously ? comment.byUnReactingToComment() : comment.byLikingComment();
    emitAndNotify(_model.byUpdatingCommentWithId(comment.id, (old) => newComment));
    _model.messenger.onUpdatedComments?.call(_model.comments);

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

  void onTapReply(CommentPreview comment) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCommentsReplyButton,
      ),
    );
    emitAndNotify(
      _model.copyWith(
        replyingComment: comment,
      ),
    );
  }

  void onTapCancelReply() {
    emitAndNotify(
      _model.copyWith(
        replyingComment: const CommentPreview.empty(),
      ),
    );
  }

  Future<void> onTapBookmark() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postBookmarkButton,
      ),
    );
    return _executeBookmarkUseCase();
  }

  Future<void> onDoubleTapPost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postLikeButton,
        targetValue: (!_model.post.iLiked).toString(),
      ),
    );
    if (!_model.post.iLiked) {
      emitAndNotify(_model.copyWith(heartLastAnimatedAt: _currentTimeProvider.currentTime));
      await _executeLikeReactUnReactPostUseCase();
    }
  }

  Future<void> onTapLikePost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postLikeButton,
        targetValue: (!_model.post.iLiked).toString(),
      ),
    );
    await _executeLikeReactUnReactPostUseCase();
  }

  Future<void> onTapDislikePost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postDislikeButton,
        targetValue: (!_model.post.iDisliked).toString(),
      ),
    );
    await _executeDislikeReactUnReactPostUseCase();
  }

  Future<void> onTapChat() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postOpenChatButton,
      ),
    );
    if (state.onTapCommentsInHorizontalMode != null && state.displayOptions.commentsMode == CommentsMode.drawer) {
      state.onTapCommentsInHorizontalMode?.call();
    } else {
      await navigator.openCommentChat(
        CommentChatInitialParams(
          post: _model.post,
          onPostUpdated: (post) => emitAndNotify(
            _model.copyWith(post: post),
          ),
        ),
      );
    }
    await _refreshCommentsAndPost();
  }

  Future<void> onCommentsDrawerClosed() async {
    await _refreshCommentsAndPost();
  }

  void onTapShare() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postShareButton,
      ),
    );
    navigator.shareText(text: _model.post.shareLink);

    _sharePostUseCase
        .execute(
          postId: _model.post.id,
        )
        .doOn(
          success: (_) => emitAndNotify(_model.byUpdatingShareStatus()),
        )
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<void> onTapReportActions() async {
    final reportType = await navigator.openReportedContent(
      ReportedContentInitialParams(
        author: _model.author,
        circleId: _model.post.circle.id,
        reportId: _model.reportId,
        reportType: ReportEntityType.post,
      ),
    );
    if (reportType != null) {
      _model.messenger.reportActionTaken(reportType.toPostRouteResult());
    }
  }

  void onTapFollow() {
    final previousFollow = _model.post.author.iFollow;

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postFollowUserButton,
      ),
    );
    emitAndNotify(_model.byUpdatingAuthorWithFollow(follow: true));
    _followUnfollowUseCase
        .execute(
          userId: _model.author.id,
          follow: true,
        ) //
        .doOn(
          success: (success) => emitAndNotify(_model.byUpdatingAuthorWithFollow(follow: true)),
        )
        .doOn(
      fail: (fail) {
        emitAndNotify(_model.byUpdatingAuthorWithFollow(follow: previousFollow));
        navigator.showError(fail.displayableFailure());
      },
    );
  }

  Future<void> onTapShowCircle() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCircleTap,
      ),
    );
    await navigator.openCircleDetails(CircleDetailsInitialParams(circleId: _model.post.circle.id));
    await _refreshPostDetails();
  }

  Future<void> onJoinCircle() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postJoinCircleButton,
      ),
    );
    return _executeJoinCircleUseCase();
  }

  Future<void> onTapProfile({
    Id? id,
  }) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postUserTap,
      ),
    );
    id ??= _model.author.id;

    await navigator.openProfile(userId: id);

    await _refreshPostDetails();
  }

  Future<void> onTapCircleAvatar() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCircleTap,
      ),
    );
    await navigator.openCircleDetails(CircleDetailsInitialParams(circleId: _model.post.circle.id));
    await _refreshPostDetails();
  }

  void didUpdateDependencies({
    required Post post,
    required PostDetailsMode mode,
  }) {
    emitAndNotify(
      _model.copyWith(
        post: post,
        displayOptions: _model.displayOptions.copyWith(
          detailsMode: mode,
        ),
      ),
    );
  }

  // determines if post has changed and notifies the enclosing page if so
  void emitAndNotify(PostOverlayViewModel state) {
    final oldPost = _model.post;
    tryEmit(state);
    final newPost = _model.post;
    if (oldPost != newPost) {
      _model.messenger.postUpdated(state.post);
    }
  }

  void commentBarHeightChanged(double height) => _model.messenger.commentBarSizeChanged?.call(height);

  void onTapComment(TreeComment comment) {
    navigator.openCommentChat(
      CommentChatInitialParams(
        post: _model.post,
        initialComment: comment,
      ),
    );
  }

  void onLongPress(CommentPreview comment) {
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
        onTapLikeReactUnReactComment(comment);
      },
      onTapDelete: _model.post.circle.permissions.canManageComments || comment.author.id == _model.privateProfile.id
          ? () {
              navigator.close();
              _onDeleteComment(comment);
            }
          : null,
      onTapPin: null,
      onTapUnpin: null,
      onTapShare: () => navigator.shareText(text: comment.text),
      onTapClose: navigator.close,
      onTapShareCommentItem: onTapShareCommentItem,
    );
  }

  void onTapShareCommentItem(String text) {
    navigator.shareText(text: text);
  }

  void onDoubleTapComment(CommentPreview comment) {
    if (!comment.iLiked) {
      onTapLikeReactUnReactComment(comment);
    }
  }

  void onVideoControlsAppeared() {
    emitAndNotify(_model.copyWith(videoControlsVisible: true));
  }

  void onVideoControlsDisappeared() {
    emitAndNotify(_model.copyWith(videoControlsVisible: false));
  }

  void onVideoEnteredLandscapeMode({
    required VoidCallback onTapComments,
    required VoidCallback onTapBack,
  }) {
    emitAndNotify(
      _model.copyWith(
        onTapBack: onTapBack,
        onTapCommentsInHorizontalMode: onTapComments,
        displayOptions: _model.displayOptions.copyWith(commentsMode: CommentsMode.drawer),
      ),
    );
  }

  void onVideoExitedLandscapeMode() {
    emitAndNotify(
      _model.copyWith(
        displayOptions: _model.displayOptions.copyWith(commentsMode: CommentsMode.overlay),
      ),
    );
  }

  Future<Either<JoinCircleFailure, Unit>> _executeJoinCircleUseCase() {
    final circle = _model.post.circle;
    if (!circle.iJoined) {
      void emitStatus({required bool joined}) {
        emitAndNotify(_model.byUpdatingJoinedStatus(iJoined: joined));
        _model.messenger.postUpdated(_model.post);
      }

      //this updates the UI immediately on tap
      emitStatus(joined: true);
      return _joinCircleUseCase.execute(circle: circle).doOn(
            success: (_) => emitStatus(joined: true),
            fail: (_) => emitStatus(joined: false),
          );
    }
    return Future.value(success(unit));
  }

  Future<void> _executeLikeReactUnReactPostUseCase() async {
    final initialReaction = _model.post.context.reaction;
    final iLikedPreviously = _model.post.iLiked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iLikedPreviously ? _model.post.byUnReactingToPost() : _model.post.byLikingPost();
    emitAndNotify(_model.copyWith(post: newPost));

    if (iLikedPreviously) {
      await _unReactToPostUseCase.execute(postId: _model.post.id).doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.post, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikePostUseCase
          .execute(
        id: _model.post.id,
        likeDislikeReaction: LikeDislikeReaction.like,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.post, initialReaction: initialReaction);
        },
      );
    }
  }

  Future<void> _executeDislikeReactUnReactPostUseCase() async {
    final initialReaction = _model.post.context.reaction;
    final iDislikedPreviously = _model.post.iDisliked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iDislikedPreviously ? _model.post.byUnReactingToPost() : _model.post.byDislikingPost();
    emitAndNotify(_model.copyWith(post: newPost));

    if (iDislikedPreviously) {
      await _unReactToPostUseCase.execute(postId: _model.post.id).doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.post, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikePostUseCase
          .execute(
        id: _model.post.id,
        likeDislikeReaction: LikeDislikeReaction.dislike,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialPostReaction(post: _model.post, initialReaction: initialReaction);
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
    emitAndNotify(_model.copyWith(post: newPost));
  }

  void _reEmitInitialCommentReaction({
    required CommentPreview comment,
    required LikeDislikeReaction initialReaction,
  }) {
    late CommentPreview newComment;
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
    emitAndNotify(_model.byUpdatingCommentWithId(comment.id, (old) => newComment));
  }

  Future<Either<SavePostToCollectionFailure, Post>> _executeBookmarkUseCase() {
    final previousState = _model.post.context.saved;

    void emitStatus({required bool saved}) {
      emitAndNotify(_model.byUpdatingSavedStatus(iSaved: saved));
      _model.messenger.postUpdated(_model.post);
    }

    //this updates the UI immediately on tap
    emitStatus(saved: !previousState);
    return _savePostToCollectionUseCase
        .execute(
      input: SavePostInput(
        postId: _model.post.id,
        save: !previousState,
      ),
    )
        .observeStatusChanges(
      (result) {
        emitAndNotify(_model.copyWith(savePostResult: result));
      },
    ).doOn(
      success: (post) {
        emitStatus(saved: post.context.saved);
        _showSavePostSuccess(post);
      },
      fail: (fail) => emitStatus(saved: previousState),
    );
  }

  void _showSavePostSuccess(Post post) {
    if (_model.showSavePostToCollection && post.context.saved) {
      navigator.showSnackBarWithWidget(
        SavedPostSnackBar(
          post: post,
          onTap: () {
            _onTapSavePostToCollection();
          },
        ),
      );
    }
  }

  void _onReportComment(CommentPreview comment) => navigator.openReportForm(
        ReportFormInitialParams(
          circleId: _model.post.circle.id,
          entityId: comment.id,
          reportEntityType: ReportEntityType.comment,
          contentAuthorId: comment.author.id,
        ),
      );

  void _onDeleteComment(CommentPreview comment) => _deleteCommentUseCase
          .execute(commentId: comment.id)
          .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()))
          .doOn(
        success: (_) {
          emitAndNotify(_model.byRemovingComment(comment));
          _model.messenger.onUpdatedComments?.call(_model.comments);
        },
      );

  Future<void> _refreshComments() {
    return _getCommentsPreviewUseCase
        .execute(
          postId: _model.post.id,
          count: _model.maxCommentsCount,
        )
        .doOn(
          //intentionally doing nothing right now since we don't have designs of failed loading of comments
          fail: (fail) => doNothing(),
          success: (comments) {
            emitAndNotify(_model.copyWith(comments: comments));
            _model.messenger.onUpdatedComments?.call(_model.comments);
          },
        );
  }

  Future<Either<GetPostByIdFailure, Post>> _refreshPostDetails() {
    return _getPostUseCase
        .execute(postId: _model.post.id) //
        .doOn(
      success: (post) {
        emitAndNotify(_model.copyWith(post: post));
      },
    );
  }

  Future<void> _refreshCommentsAndPost() async {
    await Future.wait([
      _refreshComments(),
      _refreshPostDetails(),
    ]);
  }

  void _onTapSavePostToCollection() {
    navigator.openSavePostToCollectionBottomSheet(
      SavePostToCollectionInitialParams(userId: _model.privateProfile.id, postId: _model.post.id),
    );
  }
}
