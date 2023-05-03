import 'dart:io';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerFactory {
  VideoPlayerController build(VideoUrl videoUrl) {
    return videoUrl.isFile
        ? VideoPlayerController.file(
            File(videoUrl.url),
            videoPlayerOptions: VideoPlayerOptions(),
          )
        : VideoPlayerController.network(
            videoUrl.url,
            // this makes sure `mixWithOthers` is not null and set to false by default, so that
            // video_player-2.5.2/lib/video_player.dart:359 can properly send the message to native platform to set it to
            // false explicitly. If we didn't set up those options, video player won't send any message to native platform
            videoPlayerOptions: VideoPlayerOptions(),
          );
  }
}
