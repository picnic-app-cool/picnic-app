import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class LinkPostContent extends Equatable implements PostContent {
  const LinkPostContent({
    required this.linkUrl,
    required this.metadata,
  });

  const LinkPostContent.empty()
      : linkUrl = const LinkUrl.empty(),
        metadata = const LinkMetadata.empty();

  final LinkUrl linkUrl;
  final LinkMetadata metadata;

  @override
  List<Object?> get props => [
        linkUrl,
        metadata,
      ];

  @override
  PostType get type => PostType.link;

  LinkPostContent copyWith({
    LinkUrl? linkUrl,
    LinkMetadata? metadata,
  }) {
    return LinkPostContent(
      linkUrl: linkUrl ?? this.linkUrl,
      metadata: metadata ?? this.metadata,
    );
  }
}
