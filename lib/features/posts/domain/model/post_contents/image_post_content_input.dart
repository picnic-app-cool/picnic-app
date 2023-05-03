import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_with_caption.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class ImagePostContentInput extends Equatable implements PostContentInput, PostWithCaption {
  const ImagePostContentInput({
    required this.imageFilePath,
    required this.text,
  });

  const ImagePostContentInput.empty()
      : text = '',
        imageFilePath = '';

  final String imageFilePath;

  @override
  final String text;

  @override
  List<Object?> get props => [
        imageFilePath,
        text,
      ];

  @override
  PostType get type => PostType.image;

  ImagePostContentInput copyWith({
    String? imageFilePath,
    String? text,
  }) {
    return ImagePostContentInput(
      imageFilePath: imageFilePath ?? this.imageFilePath,
      text: text ?? this.text,
    );
  }
}
