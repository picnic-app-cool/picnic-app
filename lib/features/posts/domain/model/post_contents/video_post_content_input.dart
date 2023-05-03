import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_with_caption.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class VideoPostContentInput extends Equatable implements PostContentInput, PostWithCaption {
  const VideoPostContentInput({
    required this.videoFilePath,
    this.text = '',
  });

  const VideoPostContentInput.empty()
      : videoFilePath = '',
        text = '';

  final String videoFilePath;

  @override
  final String text;

  @override
  List<Object?> get props => [
        videoFilePath,
        text,
      ];

  @override
  PostType get type => PostType.video;

  VideoPostContentInput copyWith({
    String? videoFilePath,
    String? text,
  }) {
    return VideoPostContentInput(
      videoFilePath: videoFilePath ?? this.videoFilePath,
      text: text ?? this.text,
    );
  }
}
