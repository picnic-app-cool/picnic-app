// ignore_for_file: unused-code, unused-files
import 'package:equatable/equatable.dart';

class VideoUrl extends Equatable {
  const VideoUrl(
    this.url,
  );

  const VideoUrl.empty() : url = '';

  final String url;

  bool get isFile => url.isNotEmpty && !url.contains("http://") && !url.contains("https://");

  @override
  List<Object> get props => [
        url,
      ];

  VideoUrl copyWith({
    String? url,
  }) {
    return VideoUrl(
      url ?? this.url,
    );
  }
}
