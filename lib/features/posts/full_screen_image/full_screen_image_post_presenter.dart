import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_dislike_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_post_use_case.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/saved_post_snackbar.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class FullScreenImagePostPresenter extends Cubit<FullScreenImagePostViewModel> {
  FullScreenImagePostPresenter(
    super.model,
    this.navigator,
    this._deletePostsUseCase,
    this._joinCircleUseCase,
    this._logAnalyticsEventUseCase,
    this._getPostUseCase,
    this._sharePostUseCase,
    this._likeDislikePostUseCase,
    this._unReactToPostUseCase,
    this._savePostToCollectionUseCase,
  );

  final FullScreenImagePostNavigator navigator;
  final DeletePostsUseCase _deletePostsUseCase;
  final JoinCircleUseCase _joinCircleUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final GetPostUseCase _getPostUseCase;
  final SharePostUseCase _sharePostUseCase;
  final LikeDislikePostUseCase _likeDislikePostUseCase;
  final UnreactToPostUseCase _unReactToPostUseCase;
  final SavePostToCollectionUseCase _savePostToCollectionUseCase;

  // ignore: unused_element
  FullScreenImagePostPresentationModel get _model => state as FullScreenImagePostPresentationModel;

  Future<void> onTapShowCircle() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postCircleTap,
      ),
    );
    await navigator.openCircleDetails(CircleDetailsInitialParams(circleId: _model.post.circle.id));
    await _refreshPostDetails();
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

  Future<void> onJoinCircle() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postJoinCircleButton,
      ),
    );
    return _executeJoinCircleUseCase();
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

  void onTapBack() => navigator.close();

  Future<void> onTapChat() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postOpenChatButton,
      ),
    );
    await navigator.openCommentChat(
      CommentChatInitialParams(
        post: _model.post,
        onPostUpdated: (post) => tryEmit(
          _model.copyWith(post: post),
        ),
      ),
    );
  }

  void onTapReportPost() => navigator.openReportForm(
        ReportFormInitialParams(
          entityId: _model.post.id,
          circleId: _model.post.circle.id,
          reportEntityType: ReportEntityType.post,
          contentAuthorId: _model.post.author.id,
        ),
      );

  Future<void> onTapLikePost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postLikeButton,
        targetValue: (!_model.post.iLiked).toString(),
      ),
    );
    await _executeLikeReactUnReactUseCase();
    await _refreshPostDetails();
  }

  Future<void> onTapDislikePost() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postDislikeButton,
        targetValue: (!_model.post.iDisliked).toString(),
      ),
    );
    await _executeDislikeReactUnReactUseCase();
  }

  Future<void> onTapBookmark() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postBookmarkButton,
      ),
    );
    return _executeBookmarkUseCase();
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
          success: (_) => tryEmit(_model.byUpdatingShareStatus()),
        )
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<Either<JoinCircleFailure, Unit>> _executeJoinCircleUseCase() {
    void emitStatus({required bool joined}) {
      tryEmit(_model.byUpdatingJoinedStatus(iJoined: joined));
    }

    //this updates the UI immediately on tap
    emitStatus(joined: true);
    return _joinCircleUseCase.execute(circle: _model.post.circle).doOn(
          success: (_) => emitStatus(joined: true),
          fail: (_) => emitStatus(joined: false),
        );
  }

  Future<Either<SavePostToCollectionFailure, Post>> _executeBookmarkUseCase() {
    final previousState = _model.post.context.saved;

    void emitStatus({required bool saved}) {
      tryEmit(_model.byUpdatingSavedStatus(iSaved: saved));
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
        tryEmit(_model.copyWith(savePostResult: result));
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
    if (post.context.saved) {
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

  void _onTapSavePostToCollection() {
    navigator.openSavePostToCollectionBottomSheet(
      SavePostToCollectionInitialParams(userId: _model.privateProfile.id, postId: _model.post.id),
    );
  }

  Future<void> _executeLikeReactUnReactUseCase() async {
    final initialReaction = _model.post.context.reaction;
    final iLikedPreviously = _model.post.iLiked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iLikedPreviously ? _model.post.byUnReactingToPost() : _model.post.byLikingPost();
    tryEmit(_model.copyWith(post: newPost));

    if (iLikedPreviously) {
      await _unReactToPostUseCase.execute(postId: _model.post.id).doOn(
        fail: (fail) {
          _reEmitInitialReaction(post: _model.post, initialReaction: initialReaction);
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
          _reEmitInitialReaction(post: _model.post, initialReaction: initialReaction);
        },
      );
    }
  }

  Future<Either<GetPostByIdFailure, Post>> _refreshPostDetails() {
    return _getPostUseCase
        .execute(postId: _model.post.id) //
        .doOn(
      success: (post) {
        tryEmit(_model.copyWith(post: post));
      },
    );
  }

  Future<void> _executeDislikeReactUnReactUseCase() async {
    final initialReaction = _model.post.context.reaction;
    final iDislikedPreviously = _model.post.iDisliked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iDislikedPreviously ? _model.post.byUnReactingToPost() : _model.post.byDislikingPost();
    tryEmit(_model.copyWith(post: newPost));

    if (iDislikedPreviously) {
      await _unReactToPostUseCase.execute(postId: _model.post.id).doOn(
        fail: (fail) {
          _reEmitInitialReaction(post: _model.post, initialReaction: initialReaction);
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
          _reEmitInitialReaction(post: _model.post, initialReaction: initialReaction);
        },
      );
    }
  }

  void _reEmitInitialReaction({
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
    tryEmit(_model.copyWith(post: newPost));
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
          _deletePostsUseCase.execute(postIds: [_model.post.id]).doOn(
            success: (success) => navigator.closeWithResult(const PostRouteResult(postRemoved: true)),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }
}
