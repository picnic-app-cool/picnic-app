import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/time_duration_formatter.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/expand_to_full_screen_button.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/picnic_video_progress_bar.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/play_pause_button.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_player_controls_dimensions.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_player_controls_notifier.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_scrubbing_progress_colors.dart';
import 'package:video_player/video_player.dart';

//TODO - Remove all //ignore warnings - https://picnic-app.atlassian.net/browse/GS-6109
class PicnicVideoPlayerCustomControls extends StatefulWidget {
  const PicnicVideoPlayerCustomControls({
    required this.colors,
    required this.controlsBottomPadding,
    this.onVideoControlsAppeared,
    this.onVideoControlsDisappeared,
    this.onFullScreenEnter,
    this.onFullScreenExit,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onVideoControlsAppeared;
  final VoidCallback? onVideoControlsDisappeared;
  final VoidCallback? onFullScreenEnter;
  final VoidCallback? onFullScreenExit;
  final VideoScrubbingProgressColors colors;
  final double controlsBottomPadding;

  @override
  State<StatefulWidget> createState() {
    return _PicnicVideoPlayerCustomControls();
  }
}

//ignore: no-magic-number
class _PicnicVideoPlayerCustomControls extends State<PicnicVideoPlayerCustomControls>
    with SingleTickerProviderStateMixin {
  VideoPlayerControlsNotifier notifier = VideoPlayerControlsNotifier();

  late VideoPlayerController controller;

  late VideoPlayerValue _latestValue;

  Timer? _hideTimer;
  Timer? _initTimer;
  bool _dragging = false;
  bool _displayTapped = false;

  ChewieController? _chewieController;

  ChewieController get chewieController => _chewieController!;

  @override
  Widget build(BuildContext context) {
    if (_latestValue.hasError) {
      return chewieController.errorBuilder?.call(
            context,
            chewieController.videoPlayerController.value.errorDescription!,
          ) ??
          const Center(
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 42,
            ),
          );
    }

    return GestureDetector(
      //ignore: prefer-extracting-callbacks
      onTap: () {
        _handleTap();
      },
      child: AbsorbPointer(
        absorbing: notifier.hideControls,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // ignore: avoid-returning-widgets
            _buildHitArea(),
            SafeArea(
              child: Container(
                //ignore: no-magic-number
                margin: EdgeInsets.only(
                  bottom: chewieController.isFullScreen
                      ? VideoPlayerControlsDimensions.horizontalVideoScrubbingBottomMargin
                      : widget.controlsBottomPadding,
                ),
                // ignore: avoid-returning-widgets
                child: _buildBottomBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final oldController = _chewieController;
    _chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    if (oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  void _dispose() {
    controller.removeListener(() {
      if (!mounted) {
        return;
      }

      setState(() {
        _latestValue = controller.value;
      });
    });
    _hideTimer?.cancel();
    _initTimer?.cancel();
  }

  //ignore: no-magic-number
  //ignore: long-method
  AnimatedOpacity _buildBottomBar(
    BuildContext context,
  ) {
    final iconColor = Theme.of(context).textTheme.labelLarge!.color;

    return AnimatedOpacity(
      opacity: notifier.hideControls ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        //ignore: no-magic-number
        height: VideoPlayerControlsDimensions.scrubbingControlsHeight,
        padding: EdgeInsets.only(
          //ignore: no-magic-number
          left: chewieController.isFullScreen
              ? VideoPlayerControlsDimensions.horizontalVideoHorizontalMargin
              : VideoPlayerControlsDimensions.verticalVideoScrubbingLeftMargin,
          right: chewieController.isFullScreen
              ? VideoPlayerControlsDimensions.horizontalScrubbingRightMargin
              : VideoPlayerControlsDimensions.verticalVideoScrubbingRightMargin,
          //ignore: no-magic-number
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Row(
                children: <Widget>[
                  //ignore: avoid-returning-widgets
                  _buildPosition(iconColor),
                  const Spacer(),
                  if (chewieController.allowFullScreen)
                    ExpandToFullScreenButton(
                      isFullScreen: chewieController.isFullScreen,
                      expandIconIsHidden: notifier.hideControls,
                      onTapExpand: _onExpandCollapse,
                    ),
                  //       const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  //ignore: avoid-returning-widgets
                  _buildProgressBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onExpandCollapse() {
    setState(() {
      notifier.hideControls = true;
      chewieController.toggleFullScreen();
      if (chewieController.isFullScreen) {
        widget.onFullScreenEnter?.call();
      } else {
        widget.onFullScreenExit?.call();
      }
    });
  }

  //ignore: long-method
  Widget _buildHitArea() {
    final isFinished = _latestValue.position >= _latestValue.duration;
    final showPlayButton = !_dragging && !notifier.hideControls;

    return GestureDetector(
      //ignore: prefer-extracting-callbacks
      onTap: () {
        _onHitAreaTap();
      },
      child: PlayPauseButton(
        backgroundColor: Colors.black54,
        iconColor: Colors.white,
        isFinished: isFinished,
        isPlaying: controller.value.isPlaying,
        show: showPlayButton,
        onPressed: _playPause,
      ),
    );
  }

  void _onHitAreaTap() {
    if (_latestValue.isPlaying) {
      if (_displayTapped) {
        _hideControlsTapArea();
      } else {
        _showControlsTapArea();
      }
    } else {
      _hideControlsTapArea();
      _playController(false);
    }
  }

  void _hideControlsTapArea() {
    _hideTimer?.cancel();
    setState(() {
      notifier.hideControls = true;
      widget.onVideoControlsDisappeared?.call();
    });
  }

  void _showControlsTapArea() {
    final hideControlsTimer = chewieController.hideControlsTimer.isNegative
        ? ChewieController.defaultHideControlsTimer
        : chewieController.hideControlsTimer;
    _hideTimer = Timer(hideControlsTimer, _hideControls);
    setState(() {
      notifier.hideControls = false;
      widget.onVideoControlsAppeared?.call();
      _displayTapped = true;
    });
  }

  Widget _buildPosition(Color? iconColor) {
    final position = _latestValue.position;
    final duration = _latestValue.duration;

    return RichText(
      text: TextSpan(
        text: '${formatTimeDuration(position)} ',
        children: <InlineSpan>[
          TextSpan(
            text: '/ ${formatTimeDuration(duration)}',
            style: TextStyle(
              //ignore: no-magic-number
              fontSize: 14.0,
              //ignore: no-magic-number
              color: Colors.white.withOpacity(.75),
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //ignore: maximum-nesting
  //ignore: long-method
  Future<void> _initialize() async {
    controller.addListener(_updateLatestValue);
    _latestValue = controller.value;
    _handleControls();
  }

  void _updateLatestValue() {
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _latestValue = controller.value;
      });
    });
  }

  void _handleControls() {
    if (controller.value.isPlaying || chewieController.autoPlay) {
      final hideControlsTimer = chewieController.hideControlsTimer.isNegative
          ? ChewieController.defaultHideControlsTimer
          : chewieController.hideControlsTimer;
      _hideTimer = Timer(hideControlsTimer, _hideControls);
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), _showControls);
    }
  }

  void _hideControls() {
    setState(() {
      notifier.hideControls = true;
      widget.onVideoControlsDisappeared?.call();
    });
  }

  void _showControls() {
    setState(() {
      notifier.hideControls = false;
      widget.onVideoControlsAppeared?.call();
    });
  }

  //ignore: long-method
  void _playPause() {
    final isFinished = _latestValue.position >= _latestValue.duration;

    if (controller.value.isPlaying) {
      _handlePause();
    } else {
      _handlePlay(isFinished);
    }
  }

  void _handlePause() {
    setState(() {
      notifier.hideControls = false;
      widget.onVideoControlsAppeared?.call();
      _hideTimer?.cancel();
      controller.pause();
    });
  }

  void _handlePlay(bool isFinished) {
    _hideTimer?.cancel();
    final hideControlsTimer = chewieController.hideControlsTimer.isNegative
        ? ChewieController.defaultHideControlsTimer
        : chewieController.hideControlsTimer;
    //ignore: prefer-extracting-callbacks
    _initHideTimer(hideControlsTimer);

    setState(() {
      notifier.hideControls = false;
      widget.onVideoControlsAppeared?.call();
      _displayTapped = true;
    });

    if (!controller.value.isInitialized) {
      //ignore: prefer-extracting-callbacks
      //ignore: prefer-async-await
      _initControllerThenPlay();
    } else {
      _playController(isFinished);
    }
  }

  void _playController(bool isFinished) {
    if (isFinished) {
      controller.seekTo(Duration.zero);
    }
    controller.play();
  }

  void _initControllerThenPlay() {
    //ignore: prefer-extracting-callbacks
    //ignore: prefer-async-await
    controller.initialize().then((_) {
      controller.play();
    });
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: PicnicVideoProgressBar(
        controller,
        //ignore: prefer-extracting-callbacks
        onDragStart: () {
          _onDragStart();
        },
        //ignore: prefer-extracting-callbacks
        onDragEnd: () {
          _onDragEnd();
        },
        colors: widget.colors,
      ),
    );
  }

  void _onDragStart() {
    setState(() {
      _dragging = true;
    });

    _hideTimer?.cancel();
  }

  void _onDragEnd() {
    setState(() {
      _dragging = false;
    });
    _handlePlay(false);
  }

  void _handleTap() {
    if (notifier.hideControls) {
      _playPause();
    } else {
      _hideTimer?.cancel();
      final hideControlsTimer = chewieController.hideControlsTimer.isNegative
          ? ChewieController.defaultHideControlsTimer
          : chewieController.hideControlsTimer;
      //ignore: prefer-extracting-callbacks
      _initHideTimer(hideControlsTimer);
      setState(() {
        notifier.hideControls = false;
        widget.onVideoControlsAppeared?.call();
        _displayTapped = true;
      });
    }
  }

  //ignore: prefer-extracting-callbacks
  void _initHideTimer(Duration hideControlsTimer) {
    //ignore: prefer-extracting-callbacks
    _hideTimer = Timer(hideControlsTimer, () {
      setState(() {
        notifier.hideControls = true;
        widget.onVideoControlsDisappeared?.call();
      });
    });
  }
}
