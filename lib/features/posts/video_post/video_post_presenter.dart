import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/stores/video_mute_store.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_navigator.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presentation_model.dart';

class VideoPostPresenter extends Cubit<VideoPostViewModel> with SubscriptionsMixin implements PostsListInfoListener {
  VideoPostPresenter(
    VideoPostPresentationModel model,
    this.navigator,
    this._videoMuteStore,
    this._currentTimeProvider,
  ) : super(model);

  final VideoPostNavigator navigator;
  PostOverlayPresenter? postOverlayPresenter;
  final VideoMuteStore _videoMuteStore;
  final CurrentTimeProvider _currentTimeProvider;
  static const _videoMuteSubscription = "videoMuteSubscription";

  // ignore: unused_element
  VideoPostPresentationModel get _model => state as VideoPostPresentationModel;

  void onInit() {
    listenTo<bool>(
      subscriptionId: _videoMuteSubscription,
      stream: _videoMuteStore.stream,
      onChange: (muted) {
        if (_model.allowUnmute) {
          tryEmit(_model.copyWith(muted: muted));
        }
      },
    );
    final listInfoProvider = _model.postsListInfoProvider;

    if (_model.allowUnmute) {
      _videoMuteStore.muted = _model.muted;
      tryEmit(_model.copyWith(muted: _videoMuteStore.muted));
    }
    listInfoProvider?.addListener(this);
    if (listInfoProvider == null) {
      postDidAppear(_model.post);
    }
  }

  void updateInitialParams(VideoPostInitialParams initialParams) {
    tryEmit(
      _model.copyWith(
        post: initialParams.post,
        reportId: initialParams.reportId,
        displayOptions: _model.displayOptions.copyWith(
          detailsMode: initialParams.mode,
          overlaySize: initialParams.overlaySize,
          showPostCommentBar: initialParams.showPostCommentBar,
          showTimestamp: initialParams.showTimestamp,
          showPostSummaryBarAbovePost: initialParams.showPostSummaryBarAbovePost,
        ),
        fullScreenVideoDisplayOptions: _model.fullScreenVideoDisplayOptions.copyWith(
          detailsMode: initialParams.mode,
          overlaySize: initialParams.overlaySize,
          showPostCommentBar: initialParams.showPostCommentBar,
          showTimestamp: initialParams.showTimestamp,
        ),
        onPostUpdatedCallback: initialParams.onPostUpdated,
        postsListInfoProvider: initialParams.postsListInfoProvider,
        allowUnmute: initialParams.allowUnmute,
        showControls: initialParams.showControls,
      ),
    );
  }

  /// we intentionally don't override `close` method, otherwise it would override SubscriptionsMixin's implementation
  void dispose() {
    _model.postsListInfoProvider?.removeListener(this);
  }

  void reportActionTaken(PostRouteResult result) => navigator.closeWithResult(result);

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(_model.post);
  }

  void onUpdatedComments(List<CommentPreview> comments) => tryEmit(_model.copyWith(comments: comments));

  void onMuteSwitch() {
    if (_model.allowUnmute) {
      _videoMuteStore.muted = !_videoMuteStore.muted;
    }
  }

  void onVideoTap() {
    tryEmit(_model.copyWith(videoLastTappedAt: _currentTimeProvider.currentTime));
  }

  @override
  void postDidAppear(Post post) {
    _updateVideoVisibility(makeVisible: post.id == _model.post.id);
  }

  @override
  void listDidDisappear() {
    _updateVideoVisibility(makeVisible: false);
  }

  void videoDidDisappear() {
    _updateVideoVisibility(makeVisible: false);
  }

  void videoDidAppear() {
    _updateVideoVisibility(makeVisible: true);
  }

  void onVideoControlsAppeared() => postOverlayPresenter?.onVideoControlsAppeared();

  void onVideoControlsDisappeared() => postOverlayPresenter?.onVideoControlsDisappeared();

  void _updateVideoVisibility({required bool makeVisible}) {
    if (_model.isCurrentlyVisible != makeVisible) {
      tryEmit(_model.copyWith(isCurrentlyVisible: makeVisible));
    }
  }
}
