import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/features/chat/widgets/chat_video_player/chat_fullscreen_video_player.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/picnic_video_player_custom_controls.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_player_controls_dimensions.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_scrubbing_progress_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:video_player/video_player.dart';

class ChatVideoPlayer extends StatefulWidget {
  const ChatVideoPlayer({
    Key? key,
    required this.url,
    required this.heroTag,
    this.backgroundColor,
    this.showControls = true,
  }) : super(key: key);

  factory ChatVideoPlayer.preview({
    required String url,
    required Object heroTag,
    Key? key,
  }) {
    return ChatVideoPlayer(
      key: key,
      heroTag: heroTag,
      url: VideoUrl(url),
      showControls: false,
    );
  }

  final VideoUrl url;
  final Object heroTag;
  final Color? backgroundColor;
  final bool showControls;

  @override
  State<ChatVideoPlayer> createState() => _ChatVideoPlayerState();
}

class _ChatVideoPlayerState extends State<ChatVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  double _aspectRatio = 1;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }

  @override
  void didUpdateWidget(covariant ChatVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url) {
      _initializeControllers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? PicnicTheme.of(context).colors.blackAndWhite.shade300,
      alignment: Alignment.center,
      child: _chewieController == null
          ? const SizedBox()
          : Chewie(
              controller: _chewieController!,
            ),
    );
  }

  //ignore: long-method
  Future<void> _initializeControllers() async {
    _disposeControllers();

    if (widget.url == const VideoUrl.empty()) {
      return;
    }

    final url = widget.url.url;
    final videoPlayerController = url.contains("http") || url.contains("https")
        ? VideoPlayerController.network(url)
        : VideoPlayerController.file(File(url));

    _videoPlayerController = videoPlayerController;

    await videoPlayerController.initialize();

    videoPlayerController.addListener(_onAspectRatioChanged);

    const white = Colors.white;
    final whiteTransparent = Colors.white.withOpacity(0.12);

    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      customControls: PicnicVideoPlayerCustomControls(
        controlsBottomPadding: VideoPlayerControlsDimensions.chatVideoScrubbingBottomMargin,
        colors: VideoScrubbingProgressColors(
          backgroundColor: whiteTransparent,
          handleColor: white,
          playedColor: white,
        ),
      ),
      allowFullScreen: false,
      showControls: widget.showControls,
      routePageBuilder: (
        context,
        animation,
        secondaryAnimation,
        controllerProvider,
      ) {
        return ChatFullscreenVideoPlayer(
          chewieController: controllerProvider.controller,
          heroTag: widget.heroTag,
        );
      },
    );

    if (mounted) {
      setState(() {
        _chewieController = chewieController;
      });
    }
  }

  void _disposeControllers() {
    _videoPlayerController?.removeListener(_onAspectRatioChanged);
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
    _chewieController?.dispose();
    _chewieController = null;
  }

  void _onAspectRatioChanged() {
    final aspectRatio = _videoPlayerController?.value.aspectRatio;
    if (mounted && aspectRatio != null && aspectRatio != _aspectRatio) {
      setState(() => _aspectRatio = aspectRatio);
    }
  }
}
