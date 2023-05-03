import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';

class GqlLinkMetadata {
  const GqlLinkMetadata({
    required this.title,
    required this.host,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  factory GqlLinkMetadata.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlLinkMetadata(
      title: asT<String>(json, 'title'),
      host: asT<String>(json, 'host'),
      description: asT<String>(json, 'description'),
      imageUrl: asT<String>(json, 'imageUrl'),
      url: asT<String>(json, 'url'),
    );
  }

  final String title;
  final String host;
  final String description;
  final String imageUrl;
  final String url;

  LinkMetadata toDomain() {
    return LinkMetadata(
      title: title,
      host: host,
      description: description,
      imageUrl: ImageUrl(imageUrl),
      url: url,
    );
  }
}
