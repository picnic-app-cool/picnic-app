import 'package:equatable/equatable.dart';

/// stores imageUrl or emoji
class ImageUrl extends Equatable {
  const ImageUrl(
    this.url,
  );

  const ImageUrl.empty() : url = '';

  final String url;

  bool get isEmoji => !isAsset && Uri.tryParse(url) == null;

  bool get isAsset => url.startsWith("assets/");

  bool get isFile => url.isNotEmpty && !url.contains("http://") && !url.contains("https://");

  @override
  List<Object> get props => [
        url,
      ];

  ImageUrl copyWith({
    String? url,
  }) {
    return ImageUrl(
      url ?? this.url,
    );
  }
}
