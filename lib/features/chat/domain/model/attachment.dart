import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class Attachment extends Equatable {
  const Attachment({
    required this.id,
    required this.filename,
    required this.url,
    required this.thumbUrl,
    required this.size,
    required this.fileType,
    required this.createdAt,
    this.isBlurred = false,
  });

  const Attachment.empty()
      : id = const Id.empty(),
        filename = '',
        url = '',
        thumbUrl = '',
        size = 0,
        fileType = '',
        createdAt = '',
        isBlurred = false;

  final Id id;
  final String filename;
  final String url;
  final String thumbUrl;
  final int size;
  final String fileType;
  final String createdAt;
  final bool isBlurred;

  bool get isVideo => fileType.contains('video');

  bool get isPdf => fileType.contains('pdf');

  //ignore: no-magic-number
  double get sizeMB => double.parse((size / 1024 / 1024).toStringAsFixed(2));

  String get pdfName => '${filename.split('/').last}.pdf';

  String get thumbnailUrl {
    if (thumbUrl.isNotEmpty) {
      return thumbUrl;
    }
    if ((url.contains("http://") || url.contains("https://")) && url.contains('.')) {
      final suffix = url.substring(url.lastIndexOf('.'));
      return url.replaceAll(suffix, '_thumb.jpg');
    }
    return url;
  }

  @override
  List<Object?> get props => [
        id,
        filename,
        url,
        thumbUrl,
        size,
        fileType,
        createdAt,
        isBlurred,
      ];

  Attachment copyWith({
    Id? id,
    String? filename,
    String? url,
    String? thumbUrl,
    int? size,
    String? fileType,
    String? createdAt,
    bool? isBlurred,
  }) {
    return Attachment(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      url: url ?? this.url,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      size: size ?? this.size,
      fileType: fileType ?? this.fileType,
      createdAt: url ?? this.createdAt,
      isBlurred: isBlurred ?? this.isBlurred,
    );
  }
}
