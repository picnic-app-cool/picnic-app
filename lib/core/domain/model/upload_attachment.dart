//ignore_for_file: forbidden_import_in_domain
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';

class UploadAttachment extends Equatable {
  const UploadAttachment({
    required this.filePath,
    required this.fileSize,
    required this.maximumAllowedFileSize,
  });

  const UploadAttachment.empty()
      : //
        filePath = '',
        fileSize = 0,
        maximumAllowedFileSize = UploadFileSize.imagePostContent;

  final String filePath;
  final int fileSize;
  final UploadFileSize maximumAllowedFileSize;

  bool get isAttachmentSizeAllowed => fileSize <= maximumAllowedFileSize.size;

  @override
  List<Object> get props => [
        filePath,
        fileSize,
        maximumAllowedFileSize,
      ];

  UploadAttachment copyWith({
    String? filePath,
    int? fileSize,
    UploadFileSize? maximumAllowedFileSize,
  }) {
    return UploadAttachment(
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      maximumAllowedFileSize: maximumAllowedFileSize ?? this.maximumAllowedFileSize,
    );
  }
}
