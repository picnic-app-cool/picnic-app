import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/save_video_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';

class SaveVideoToGalleryUseCase {
  const SaveVideoToGalleryUseCase(this._repository);

  final PhoneGalleryRepository _repository;

  Future<Either<SaveVideoToGalleryFailure, Unit>> execute({
    required String path,
  }) =>
      _repository.saveVideo(path: path);
}
