import 'package:chewie/chewie.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/video_post/horizontal_video_overlay.dart';
import 'package:picnic_app/ui/widgets/double_tap_detector.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_player_controls_dimensions.dart';

class FeedFullscreenVideoPlayer extends StatefulWidget {
  const FeedFullscreenVideoPlayer({
    required this.chewieController,
    this.commentsPageWidget,
    this.postOverlayPresenter,
  });

  final ChewieController chewieController;
  final Widget? commentsPageWidget;
  final PostOverlayPresenter? postOverlayPresenter;

  @override
  State<StatefulWidget> createState() {
    return _FeedFullscreenVideoPlayerState();
  }
}

class _FeedFullscreenVideoPlayerState extends State<FeedFullscreenVideoPlayer> {
  final spacing = const Gap(8);
  static const commentsDrawerScreenPercentage = 0.5;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    widget.postOverlayPresenter!.onVideoEnteredLandscapeMode(
      onTapComments: () => _key.currentState!.openEndDrawer(),
      onTapBack: () => widget.chewieController.exitFullScreen(),
    );
  }

  @override
  void dispose() {
    widget.postOverlayPresenter!.onVideoExitedLandscapeMode();
    _resetOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      endDrawer: widget.commentsPageWidget != null
          ? SizedBox(
              width: MediaQuery.of(context).size.width * commentsDrawerScreenPercentage,
              child: Drawer(
                child: widget.commentsPageWidget,
              ),
            )
          : null,
      endDrawerEnableOpenDragGesture: false,
      onEndDrawerChanged: _onDrawerGesture,
      body: DismissiblePage(
        backgroundColor: Colors.transparent,
        onDismissed: () => widget.chewieController.exitFullScreen(),
        direction: DismissiblePageDismissDirection.multi,
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: DoubleTapDetector(
            onDoubleTap: () => widget.postOverlayPresenter?.onDoubleTapPost(),
            child: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Stack(
                children: [
                  Center(
                    child: Chewie(
                      controller: widget.chewieController,
                    ),
                  ),
                  if (widget.postOverlayPresenter != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: VideoPlayerControlsDimensions.horizontalVideoScrubbingBottomMargin,
                        left: VideoPlayerControlsDimensions.horizontalVideoHorizontalMargin,
                        right: VideoPlayerControlsDimensions.horizontalVideoHorizontalMargin,
                      ),
                      child: HorizontalVideoOverlay(
                        presenter: widget.postOverlayPresenter!,
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDrawerGesture(bool opened) {
    if (!opened) {
      widget.postOverlayPresenter?.onCommentsDrawerClosed();
    }
  }

  Future<dynamic> _resetOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
