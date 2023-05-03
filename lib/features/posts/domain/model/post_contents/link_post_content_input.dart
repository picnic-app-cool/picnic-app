import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class LinkPostContentInput extends Equatable implements PostContentInput {
  const LinkPostContentInput({
    required this.linkUrl,
  });

  const LinkPostContentInput.empty() : linkUrl = const LinkUrl.empty();

  final LinkUrl linkUrl;

  @override
  List<Object?> get props => [
        linkUrl,
      ];

  @override
  PostType get type => PostType.link;

  LinkPostContentInput copyWith({
    LinkUrl? linkUrl,
  }) {
    return LinkPostContentInput(
      linkUrl: linkUrl ?? this.linkUrl,
    );
  }
}
