import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/blur_attachment_failure.dart';
import 'package:picnic_app/core/domain/model/get_is_blurred_attachment_failure.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/core/domain/model/upload_attachment_failure.dart';
import 'package:picnic_app/core/domain/model/video_thumbnail_failure.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

abstract class AttachmentRepository {
  Future<Either<UploadAttachmentFailure, Attachment>> uploadAttachment({
    required UploadAttachment attachment,
  });

  Future<Either<BlurAttachmentFailure, Unit>> unBlurAttachment({
    required Id attachmentId,
  });

  Future<Either<GetIsBlurredAttachmentFailure, bool>> getIsBlurredAttachment({
    required Id attachmentId,
  });

  Future<Either<VideoThumbnailFailure, String>> getThumbnail({
    required File video,
    required int maxHeight,
    required int quality,
  });
}
