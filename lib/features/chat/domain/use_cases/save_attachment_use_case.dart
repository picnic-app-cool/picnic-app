import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/download_repository.dart';
import 'package:picnic_app/core/domain/use_cases/image_watermark_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_photo_to_gallery_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_video_to_gallery_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/save_attachment_failure.dart';

class SaveAttachmentUseCase {
  const SaveAttachmentUseCase(
    this._downloadRepository,
    this._imageWatermarkUseCase,
    this._savePhotoToGalleryUseCase,
    this._saveVideoToGalleryUseCase,
  );

  final DownloadRepository _downloadRepository;
  final ImageWatermarkUseCase _imageWatermarkUseCase;
  final SavePhotoToGalleryUseCase _savePhotoToGalleryUseCase;
  final SaveVideoToGalleryUseCase _saveVideoToGalleryUseCase;

  Future<Either<SaveAttachmentFailure, Unit>> execute({
    required Attachment attachment,
    required String username,
  }) async {
    return _downloadRepository //
        .download(url: attachment.url)
        .mapFailure(SaveAttachmentFailure.unknown)
        .flatMap(
          (path) => attachment.isVideo
              ? _saveVideoToGalleryUseCase //
                  .execute(path: path)
                  .mapFailure(SaveAttachmentFailure.unknown)
              : _imageWatermarkUseCase
                  .execute(path: path, username: username)
                  .mapFailure(SaveAttachmentFailure.unknown)
                  .flatMap(
                    (path) => _savePhotoToGalleryUseCase //
                        .execute(path: path)
                        .mapFailure(SaveAttachmentFailure.unknown),
                  ),
        );
  }
}
