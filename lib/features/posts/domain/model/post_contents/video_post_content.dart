import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_with_caption.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class VideoPostContent extends Equatable implements PostContent, PostWithCaption {
  const VideoPostContent({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.text,
  });

  const VideoPostContent.empty()
      : videoUrl = const VideoUrl.empty(),
        thumbnailUrl = const ImageUrl.empty(),
        duration = Duration.zero,
        text = "";

  final VideoUrl videoUrl;
  final ImageUrl thumbnailUrl;
  final Duration duration;

  @override
  final String text;

  @override
  List<Object?> get props => [
        videoUrl,
        thumbnailUrl,
        duration,
        text,
      ];

  @override
  PostType get type => PostType.video;

  VideoPostContent copyWith({
    VideoUrl? videoUrl,
    ImageUrl? thumbnailUrl,
    Duration? duration,
    String? text,
  }) {
    return VideoPostContent(
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      text: text ?? this.text,
    );
  }
}
