import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';

class LinkMetadata extends Equatable {
  const LinkMetadata({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.host,
    required this.url,
  });

  const LinkMetadata.empty()
      : title = '',
        description = '',
        host = '',
        imageUrl = const ImageUrl.empty(),
        url = '';

  final ImageUrl imageUrl;
  final String title;
  final String description;
  final String host;
  final String url;

  @override
  List<Object> get props => [
        imageUrl,
        title,
        description,
        host,
        url,
      ];

  LinkMetadata copyWith({
    ImageUrl? imageUrl,
    String? title,
    String? description,
    String? host,
    String? url,
  }) {
    return LinkMetadata(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      host: host ?? this.host,
      url: url ?? this.url,
    );
  }
}
