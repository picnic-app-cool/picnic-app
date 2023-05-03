import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/image_watermark_failure.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';

class ImageWatermarkUseCase {
  const ImageWatermarkUseCase(this._repository);

  final PhoneGalleryRepository _repository;

  Future<Either<ImageWatermarkFailure, String>> execute({
    required String path,
    required String username,
  }) async {
    return _repository.addImageWatermark(path: path, username: username);
  }
}
