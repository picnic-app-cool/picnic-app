//ignore_for_file: forbidden_import_in_domain
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/get_upload_chat_attachment_failure.dart';

class GetUploadChatAttachmentUseCase {
  Future<Either<GetUploadChatAttachmentFailure, UploadAttachment>> execute({
    required Attachment attachment,
  }) async {
    final maximumAllowedFileSize = attachment.isPdf
        ? UploadFileSize.documentContent
        : attachment.isVideo
            ? UploadFileSize.chatVideoContent
            : UploadFileSize.chatImageContent;
    try {
      return success(
        UploadAttachment(
          filePath: attachment.url,
          fileSize: attachment.size,
          maximumAllowedFileSize: maximumAllowedFileSize,
        ),
      );
    } catch (ex) {
      return failure(GetUploadChatAttachmentFailure.unknown(ex));
    }
  }
}
