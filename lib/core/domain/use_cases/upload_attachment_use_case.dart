import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/core/domain/model/upload_attachment_failure.dart';
import 'package:picnic_app/core/domain/repositories/attachment_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';

class UploadAttachmentUseCase {
  const UploadAttachmentUseCase(this._attachmentRepository);

  final AttachmentRepository _attachmentRepository;

  Future<Either<UploadAttachmentFailure, List<Attachment>>> execute({
    required List<UploadAttachment> attachments,
  }) =>
      attachments
          .map((attachment) => _attachmentRepository.uploadAttachment(attachment: attachment))
          .zip()
          .mapFailure(UploadAttachmentFailure.unknown);
}
