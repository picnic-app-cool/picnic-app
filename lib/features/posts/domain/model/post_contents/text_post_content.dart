import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';

class TextPostContent extends Equatable implements PostContent {
  const TextPostContent({
    required this.additionalText,
    required this.text,
    required this.color,
  });

  const TextPostContent.empty()
      : text = '',
        additionalText = '',
        color = TextPostColor.none;

  final String text;
  final String additionalText;
  final TextPostColor color;

  @override
  List<Object?> get props => [
        text,
        additionalText,
        color,
      ];

  @override
  PostType get type => PostType.text;

  TextPostContent copyWith({
    String? text,
    String? additionalText,
    TextPostColor? color,
  }) {
    return TextPostContent(
      text: text ?? this.text,
      additionalText: additionalText ?? this.additionalText,
      color: color ?? this.color,
    );
  }
}
