import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';

class GqlTextPostContentInput {
  const GqlTextPostContentInput({
    required this.text,
    required this.more,
    required this.textColor,
  });

  factory GqlTextPostContentInput.fromDomain(TextPostContentInput input) => GqlTextPostContentInput(
        text: input.text.trim(),
        more: input.additionalText.trim(),
        textColor: input.color.value,
      );

  final String text;
  final String more;
  final String textColor;

  Map<String, dynamic> toJson() => {
        'text': text,
        'more': more,
        'color': textColor,
      };
}
