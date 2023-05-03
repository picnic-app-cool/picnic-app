import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';

class GqlImagePostContent {
  const GqlImagePostContent({
    required this.imageUrl,
    required this.text,
  });

  factory GqlImagePostContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlImagePostContent(
      imageUrl: asT<String>(json, 'url'),
      text: asT<String>(json, 'text'),
    );
  }

  final String imageUrl;
  final String text;

  ImagePostContent toDomain() => ImagePostContent(
        imageUrl: ImageUrl(imageUrl),
        text: text,
      );
}
