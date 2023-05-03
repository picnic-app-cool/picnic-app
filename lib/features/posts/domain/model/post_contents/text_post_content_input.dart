import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';

class TextPostContentInput extends Equatable implements PostContentInput {
  const TextPostContentInput({
    required this.additionalText,
    required this.text,
    required this.color,
  });

  const TextPostContentInput.empty()
      : text = '',
        additionalText = '',
        color = TextPostColor.none;

  final String text;
  final String additionalText;
  final TextPostColor color;

  @override
  PostType get type => PostType.text;

  @override
  List<Object?> get props => [
        text,
        additionalText,
        color,
      ];

  TextPostContentInput copyWith({
    String? text,
    String? additionalText,
    TextPostColor? color,
  }) {
    return TextPostContentInput(
      text: text ?? this.text,
      additionalText: additionalText ?? this.additionalText,
      color: color ?? this.color,
    );
  }
}
