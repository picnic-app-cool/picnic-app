import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';

class GqlTextPostContent {
  const GqlTextPostContent({
    required this.text,
    required this.additionalText,
    required this.color,
  });

  factory GqlTextPostContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlTextPostContent(
      text: asT<String>(json, 'text'),
      additionalText: asT<String>(json, 'more'),
      color: asT<String>(json, 'color'),
    );
  }

  final String text;
  final String additionalText;
  final String color;

  TextPostContent toDomain() => TextPostContent(
        text: text,
        additionalText: additionalText,
        color: TextPostColor.fromString(color),
      );
}
