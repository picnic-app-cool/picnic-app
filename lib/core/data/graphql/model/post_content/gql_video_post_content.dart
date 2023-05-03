import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';

class GqlVideoPostContent {
  const GqlVideoPostContent({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.text,
  });

  factory GqlVideoPostContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlVideoPostContent(
      videoUrl: asT<String>(json, 'url'),
      thumbnailUrl: asT<String>(json, 'thumbnailUrl'),
      duration: asT<int>(json, 'duration'),
      text: asT<String>(json, 'text'),
    );
  }

  final String videoUrl;
  final String thumbnailUrl;
  final int duration;
  final String text;

  VideoPostContent toDomain() => VideoPostContent(
        videoUrl: VideoUrl(videoUrl),
        thumbnailUrl: ImageUrl(thumbnailUrl),
        duration: Duration(seconds: duration),
        text: text,
      );
}
