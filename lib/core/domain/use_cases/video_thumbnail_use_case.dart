import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/video_thumbnail_failure.dart';
import 'package:picnic_app/core/domain/repositories/attachment_repository.dart';

class VideoThumbnailUseCase {
  const VideoThumbnailUseCase(this._attachmentRepository);

  final AttachmentRepository _attachmentRepository;

  static const _thumbnailQuality = 75;

  Future<Either<VideoThumbnailFailure, String>> execute({
    required File video,
    required int maxHeight,
    int quality = _thumbnailQuality,
  }) =>
      _attachmentRepository.getThumbnail(
        video: video,
        maxHeight: maxHeight,
        quality: quality,
      );
}
