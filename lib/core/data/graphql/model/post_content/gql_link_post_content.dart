import 'package:picnic_app/core/data/graphql/model/gql_link_metadata.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';

class GqlLinkPostContent {
  const GqlLinkPostContent({
    required this.linkUrl,
    required this.linkMetadata,
  });

  factory GqlLinkPostContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlLinkPostContent(
      linkUrl: asT<String>(json, 'url'),
      linkMetadata: GqlLinkMetadata.fromJson(
        asT<Map<String, dynamic>>(json, 'linkMetaData'),
      ),
    );
  }

  final String linkUrl;
  final GqlLinkMetadata linkMetadata;

  LinkPostContent toDomain() => LinkPostContent(
        linkUrl: LinkUrl(linkUrl),
        metadata: linkMetadata.toDomain(),
      );
}
