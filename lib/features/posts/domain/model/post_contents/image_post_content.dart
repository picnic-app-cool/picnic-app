import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_with_caption.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class ImagePostContent extends Equatable implements PostContent, PostWithCaption {
  const ImagePostContent({
    required this.imageUrl,
    required this.text,
  });

  const ImagePostContent.empty()
      : text = '',
        imageUrl = const ImageUrl.empty();

  final ImageUrl imageUrl;

  @override
  final String text;

  @override
  List<Object?> get props => [
        text,
        imageUrl,
      ];

  @override
  PostType get type => PostType.image;

  ImagePostContent copyWith({
    ImageUrl? imageUrl,
    String? text,
  }) {
    return ImagePostContent(
      imageUrl: imageUrl ?? this.imageUrl,
      text: text ?? this.text,
    );
  }
}
