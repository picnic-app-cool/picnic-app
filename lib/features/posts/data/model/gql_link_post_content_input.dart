import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content_input.dart';

class GqlLinkPostContentInput {
  const GqlLinkPostContentInput({
    required this.link,
  });

  factory GqlLinkPostContentInput.fromDomain(LinkPostContentInput input) =>
      GqlLinkPostContentInput(link: input.linkUrl.url);

  final String link;

  Map<String, dynamic> toJson() => {
        'url': link,
      };
}
