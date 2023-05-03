import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/ui/widgets/double_tap_detector.dart';
import 'package:picnic_app/ui/widgets/tap_event_interceptor.dart';
import 'package:picnic_app/ui/widgets/video_player/video_player_controller_factory.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/feed_full_screen_video_player.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/picnic_video_player_custom_controls.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_player_controls_dimensions.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_scrubbing_progress_colors.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:video_player/video_player.dart';

class PicnicVideoPlayer extends StatefulWidget {
  /// Used to play videos from the given [url]. It only plays videos if this view is
  /// visible.
  ///
  /// [forcePause] indicates whether the video should be paused no matter what
  /// the visibility is of the current video
  ///
  /// Note, the video can be paused even when [forcePause] is false,
  /// for example when the video isn't visible.
  const PicnicVideoPlayer({
    required this.url,
    this.forcePause = false,
    this.backgroundColor,
    this.onTap,
    this.muted = false,
    this.pausable = false,
    this.onVideoControlsAppeared,
    this.onVideoControlsDisappeared,
    this.onFullScreenEnter,
    this.onFullScreenExit,
    this.isInPreviewMode = false,
    this.commentsPageWidget,
    this.postOverlayPresenter,
    this.showControls = true,
  });

  final VideoUrl url;
  final bool forcePause;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final PostOverlayPresenter? postOverlayPresenter;
  final bool muted;
  final bool pausable;
  final VoidCallback? onVideoControlsAppeared;
  final VoidCallback? onVideoControlsDisappeared;
  final VoidCallback? onFullScreenEnter;
  final VoidCallback? onFullScreenExit;
  final bool isInPreviewMode;
  final Widget? commentsPageWidget;
  final bool showControls;

  static int _initializedPlayersCount = 0;

  /// when video disappears from the screen, a timer will be started with this duration that will dispose
  /// the controller after this time unless video reappears on the screen. this is done to save resources
  static const _timeToDispose = Duration(seconds: 10);

  @override
  State<PicnicVideoPlayer> createState() => _PicnicVideoPlayerState();
}

class _PicnicVideoPlayerState extends State<PicnicVideoPlayer> {
  static final List<VideoPlayerController> _controllers = [];
  static VideoPlayerController? _currentlyPlayingController;
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  double _aspectRatio = 1;

  String? _errorDescription;

  Timer? _disposeTimer;

  bool _controllerInitialized = false;

  late VideoPlayerControllerFactory _videoControllerFactory;

  double get _volume => widget.muted ? 0 : 1;

  @override
  void didUpdateWidget(covariant PicnicVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.forcePause) {
      _updatePlayState(shouldPlay: false);
    }
    if (widget.url != oldWidget.url) {
      _ensureVideoController();
    } else if (oldWidget.forcePause != widget.forcePause) {
      _updatePlayState(shouldPlay: !widget.forcePause);
    }
    _setVolumeIfNecessary();
  }

  @override
  void initState() {
    super.initState();

    ///used to mock out videoPlayerController in tests
    _videoControllerFactory = getIt<VideoPlayerControllerFactory>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _ensureVideoController();
  }

  @override
  void dispose() {
    _log("Disposing videoPlayer");
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewInForegroundDetector(
      visibilityFraction: Constants.postVisibilityThreshold,
      viewDidDisappear: () => _videoDidDisappear(),
      viewDidAppear: () => videoDidAppear(),
      child: DoubleTapDetector(
        onDoubleTap: () => widget.postOverlayPresenter?.onDoubleTapPost(),
        child: TapEventInterceptor(
          onTap: _onVideoTap,
          child: Container(
            color: widget.backgroundColor ?? PicnicTheme.of(context).colors.blackAndWhite.shade900,
            child: AspectRatio(
              aspectRatio: _aspectRatio,
              child: _chewieController == null ? const SizedBox() : Chewie(controller: _chewieController!),
            ),
          ),
        ),
      ),
    );
  }

  void videoDidAppear() {
    if (_disposeTimer != null) {
      _disposeTimer?.cancel();
    }
    if (!_controllerInitialized) {
      _ensureVideoController();
    }
    _updatePlayState(shouldPlay: true);
  }

  void _videoDidDisappear() {
    _updatePlayState(shouldPlay: false);
    _disposeTimer?.cancel();
    _disposeTimer = Timer(
      PicnicVideoPlayer._timeToDispose,
      // ignore: prefer-extracting-callbacks
      () {
        _disposeController();
        _log("disposing video player due to long time being in background");
      },
    );
  }

  Future<void> _disposeController() async {
    _controllerInitialized = false;
    await _controller?.pause();
    if (_controller != null) {
      PicnicVideoPlayer._initializedPlayersCount--;
      _controllers.remove(_controller);
    }
    final disposeFuture = _controller?.dispose();
    _controller = null;
    _chewieController?.dispose();
    _chewieController = null;

    await disposeFuture;
  }

  Future<void> _ensureVideoController() async {
    unawaited(_disposeController());
    // Video player currently doesn't work on desktop, but we use macos for testing
    // To prevent test failing we should use VideoUrl.empty in test environment.
    if (widget.url != const VideoUrl.empty()) {
      // this way we don't block the main thread
      unawaited(_createNewController());
    }
  }

  //ignore: long-method

  ChewieController _buildChewieController(VideoPlayerController controller) {
    const white = Colors.white;
    final whiteTransparent = Colors.white.withOpacity(0.12);

    return ChewieController(
      videoPlayerController: controller,
      customControls: widget.showControls
          ? widget.isInPreviewMode
              ? const MaterialControls()
              //ignore: avoid-returning-widgets
              : _buildCustomPlayerControls(whiteTransparent, white)
          : const SizedBox.shrink(),
      routePageBuilder: _buildFullScreenVideoPlayer,
      showControlsOnInitialize: false,
      looping: true,
      allowFullScreen: !widget.isInPreviewMode,
      // we intentionally don't allow for videos to autoplay, since some videoControllers might be initialized
      // when in background. only when video appears in foreground it will be automatically started in [videoDidAppear]
      // ignore: avoid_redundant_argument_values
      autoPlay: false,
    );
  }

  Widget _buildFullScreenVideoPlayer(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    ChewieControllerProvider controllerProvider,
  ) {
    return FeedFullscreenVideoPlayer(
      chewieController: controllerProvider.controller,
      commentsPageWidget: widget.commentsPageWidget,
      postOverlayPresenter: widget.postOverlayPresenter,
    );
  }

  PicnicVideoPlayerCustomControls _buildCustomPlayerControls(Color whiteTransparent, Color white) {
    return PicnicVideoPlayerCustomControls(
      controlsBottomPadding: VideoPlayerControlsDimensions.verticalVideoScrubbingBottomMargin,
      onVideoControlsAppeared: widget.onVideoControlsAppeared,
      onVideoControlsDisappeared: widget.onVideoControlsDisappeared,
      onFullScreenEnter: widget.onFullScreenEnter,
      onFullScreenExit: widget.onFullScreenExit,
      colors: VideoScrubbingProgressColors(
        backgroundColor: whiteTransparent,
        handleColor: white,
        playedColor: white,
      ),
    );
  }

  Future<void> _createNewController() async {
    _controllerInitialized = true;
    PicnicVideoPlayer._initializedPlayersCount++;
    final controller = _videoControllerFactory.build(widget.url);
    controller.addListener(() async {
      if (controller.value.errorDescription != _errorDescription) {
        _handleVideoError(controller);
      }
      if (controller.value.isPlaying && _currentlyPlayingController != controller) {
        logError("controller is playing, but it's not the currently supposed one: playing: ${widget.url}");
        await controller.pause();
      }
      _onAspectRatioChanged(controller.value.aspectRatio);
    });
    await controller.initialize();
    _log("Video player controller initialized");

    if (mounted) {
      //this makes sure the first frame is visible immediately after initialization
      setState(() => doNothing());
    }
    await controller.pause();
    _controllers.add(controller);
    _controller = controller;
    _chewieController = _buildChewieController(controller);
    await _setVolumeIfNecessary();
    if (mounted) {
      // this makes sure the video controller is set into the widget properly
      setState(() => doNothing());
    }
    _updatePlayState(shouldPlay: true);
  }

  Future<void> _setVolumeIfNecessary() async {
    final newVolume = _volume;
    final currentVolume = _controller?.value.volume;

    if (currentVolume != newVolume) {
      _log("setting new Volume: $newVolume");
      await _chewieController?.setVolume(newVolume);
    }
  }

  void _handleVideoError(VideoPlayerController controller) {
    _errorDescription = controller.value.errorDescription;
    _log("error in video playback of ${widget.url}\n: $_errorDescription");
  }

  void _onAspectRatioChanged(double aspectRatio) {
    if (_aspectRatio != aspectRatio) {
      _aspectRatio = aspectRatio;
      if (mounted) {
        setState(() => doNothing());
      }
    }
  }

  void _onVideoTap() {
    widget.onTap?.call();
  }

  void _updatePlayState({required bool shouldPlay}) {
    final isPlaying = _chewieController?.isPlaying ?? false;
    if (!widget.forcePause && shouldPlay) {
      if (!isPlaying) {
        // pause all other controllers just to make sure we have no two controllers playing at the same time
        _pauseAllOtherPlayers();
        _log("playing video in videoPlayer");
        _currentlyPlayingController = _controller;
        _chewieController?.play();
        _setVolumeIfNecessary();
      }
    } else {
      if (isPlaying) {
        _log("pausing video in videoPlayer");
        _chewieController?.pause();
      }
    }
  }

  void _pauseAllOtherPlayers() {
    _controllers //
        .where((element) => element != _controller)
        .forEach((element) {
      element.pause();
    });
  }

  void _log(String message) => debugLog(
        "$message\nplayers count=${PicnicVideoPlayer._initializedPlayersCount}\n(hash: ${widget.url.hashCode})",
        this,
      );
}
