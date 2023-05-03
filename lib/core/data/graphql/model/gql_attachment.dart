import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlAttachment {
  GqlAttachment({
    required this.id,
    required this.filename,
    required this.url,
    required this.thumbUrl,
    required this.size,
    required this.fileType,
    required this.createdAt,
  });

  factory GqlAttachment.fromJson(Map<String, dynamic>? json) {
    return GqlAttachment(
      id: asT<String>(json, 'id'),
      filename: asT<String>(json, 'filename'),
      url: asT<String>(json, 'url'),
      thumbUrl: asT<String>(json, 'thumbUrl'),
      size: asT<int>(json, 'size'),
      fileType: asT<String>(json, 'fileType'),
      createdAt: asT<String>(json, 'createdAt'),
    );
  }

  final String id;
  final String filename;
  final String url;
  final String thumbUrl;
  final int size;
  final String fileType;
  final String createdAt;

  Attachment toDomain() => Attachment(
        id: Id(id),
        filename: filename,
        url: url,
        thumbUrl: thumbUrl,
        size: size,
        fileType: fileType,
        createdAt: createdAt,
      );
}
