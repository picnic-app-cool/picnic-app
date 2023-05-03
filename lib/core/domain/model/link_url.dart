import 'package:equatable/equatable.dart';

/// stores url of a link to web
class LinkUrl extends Equatable {
  const LinkUrl(
    this.url,
  );

  const LinkUrl.empty() : url = '';

  final String url;

  @override
  List<Object> get props => [
        url,
      ];

  LinkUrl copyWith({
    String? url,
  }) {
    return LinkUrl(
      url ?? this.url,
    );
  }
}
