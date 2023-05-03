import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/video_player/picnic_video_player.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VideoPostPreview extends StatefulWidget {
  const VideoPostPreview({
    Key? key,
    required this.videoUrl,
    required this.thumbnailUrl,
  }) : super(key: key);

  final VideoUrl videoUrl;
  final ImageUrl thumbnailUrl;

  static const borderRadius = 24.0;

  @override
  State<VideoPostPreview> createState() => _VideoPostPreviewState();
}

class _VideoPostPreviewState extends State<VideoPostPreview> {
  bool _playVideo = false;

  @override
  Widget build(BuildContext context) {
    final postHeight = MediaQuery.of(context).size.height / 3.9;
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final blackColor = blackAndWhite.shade900;
    final black20 = blackColor.withOpacity(0.2);
    final black30 = blackColor.withOpacity(0.3);
    final black70 = blackColor.withOpacity(0.7);

    const playIconSize = 48.0;

    return GestureDetector(
      onTap: _onVideoTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: postHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(VideoPostPreview.borderRadius),
            child: _playVideo
                ? PicnicVideoPlayer(
                    url: widget.videoUrl,
                    isInPreviewMode: true,
                  )
                : Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                black70,
                                black30,
                                black20,
                                black30,
                                black70,
                              ],
                            ),
                          ),
                          child: Image.network(
                            widget.thumbnailUrl.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          Assets.images.play.path,
                          height: playIconSize,
                          width: playIconSize,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _onVideoTap() => setState(() => _playVideo = !_playVideo);
}
