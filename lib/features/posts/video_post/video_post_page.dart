import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_page.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_overlay.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presenter.dart';
import 'package:picnic_app/features/posts/widgets/post_overlay_gradient.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_app/ui/widgets/video_player/picnic_video_player.dart';
import 'package:picnic_app/ui/widgets/video_player/picnic_video_player_mute_switch_button.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VideoPostPage extends StatefulWidget with HasInitialParams {
  const VideoPostPage({
    required this.initialParams,
    Key? key,
  }) : super(key: key);

  @override
  final VideoPostInitialParams initialParams;

  @override
  State<VideoPostPage> createState() => _VideoPostPageState();
}

class _VideoPostPageState extends State<VideoPostPage>
    with PresenterStateMixinAuto<VideoPostViewModel, VideoPostPresenter, VideoPostPage> {
  final _muteButtonKey = GlobalKey<PicnicVideoPlayerMuteSwitchButtonState>();

  PostOverlayPresenter? _overlayPresenter;
  PostOverlayMediator? _postOverlayMediator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.onInit();
    });
  }

  @override
  void didUpdateWidget(covariant VideoPostPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    presenter.updateInitialParams(widget.initialParams);
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final muteButtonTopOffset = mediaQuery.viewPadding.top + Constants.postInFeedNavBarGapHeight + 75;
    const muteButtonRightOffset = 16.0;

    final theme = PicnicTheme.of(context);
    final black = theme.colors.blackAndWhite.shade900;
    final size = mediaQuery.size;

    final displayOptions = state.displayOptions;
    return Material(
      child: LightStatusBar(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: black,
          ),
          child: SizedBox.expand(
            child: Stack(
              children: [
                stateObserver(
                  buildWhen: (previous, current) =>
                      previous.videoUrl != current.videoUrl || //
                      previous.muted != current.muted ||
                      previous.isCurrentlyVisible != current.isCurrentlyVisible,
                  builder: (context, state) {
                    return Positioned.fill(
                      child: PicnicImage(
                        source: PicnicImageSource.imageUrl(
                          state.videoThumbnail,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
                stateObserver(
                  buildWhen: (previous, current) =>
                      previous.videoUrl != current.videoUrl || //
                      previous.muted != current.muted ||
                      previous.isCurrentlyVisible != current.isCurrentlyVisible,
                  builder: (context, state) {
                    return Positioned.fill(
                      child: ViewInForegroundDetector(
                        visibilityFraction: Constants.postVisibilityThreshold,
                        viewDidDisappear: presenter.videoDidDisappear,
                        viewDidAppear: presenter.videoDidAppear,
                        child: PicnicVideoPlayer(
                          //so that we show the thumbnail behind it
                          backgroundColor: Colors.transparent,
                          url: state.videoUrl,
                          forcePause: !state.isCurrentlyVisible,
                          muted: state.muted,
                          pausable: state.pausable,
                          onTap: presenter.onVideoTap,
                          onVideoControlsAppeared: presenter.onVideoControlsAppeared,
                          onVideoControlsDisappeared: presenter.onVideoControlsDisappeared,
                          postOverlayPresenter: _overlayPresenter,
                          commentsPageWidget: getIt<CommentChatPage>(
                            param1: CommentChatInitialParams(
                              post: state.post,
                              showAppBar: false,
                              showPostPreview: false,
                              shouldBeDisposed: false,
                            ),
                          ),
                          showControls: state.showControls,
                        ),
                      ),
                    );
                  },
                ),
                if (state.showControls && state.allowUnmute)
                  stateObserver(
                    buildWhen: (previous, current) =>
                        previous.muted != current.muted || previous.videoLastTappedAt != current.videoLastTappedAt,
                    builder: (context, state) => Positioned(
                      top: muteButtonTopOffset,
                      right: muteButtonRightOffset,
                      child: PicnicVideoPlayerMuteSwitchButton(
                        key: _muteButtonKey,
                        videoLastTappedAt: state.videoLastTappedAt,
                        muted: state.muted,
                        onTap: presenter.onMuteSwitch,
                      ),
                    ),
                  ),
                Stack(
                  children: [
                    PostOverlayGradient(size: size),
                    SafeArea(
                      bottom: displayOptions.detailsMode == PostDetailsMode.details,
                      top: displayOptions.detailsMode == PostDetailsMode.details,
                      child: PostOverlay(
                        key: ValueKey(state.post.id),
                        post: state.post,
                        reportId: state.reportId,
                        maxCommentsCount: Constants.videoPostCommentsCount,
                        messenger: _getPostOverlayMediator(),
                        displayOptions: displayOptions,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PostOverlayMediator _getPostOverlayMediator() => _postOverlayMediator ??= PostOverlayMediator(
        reportActionTaken: presenter.reportActionTaken,
        postUpdated: presenter.postUpdated,
        //ignore: prefer-extracting-callbacks
        onPresenterCreated: _setPresenter,
        onUpdatedComments: presenter.onUpdatedComments,
      );

  void _setPresenter(PostOverlayPresenter presenter) {
    _overlayPresenter = presenter;
    this.presenter.postOverlayPresenter = presenter;
  }
}
