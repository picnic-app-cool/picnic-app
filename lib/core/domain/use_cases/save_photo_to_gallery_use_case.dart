import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/save_photo_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';

class SavePhotoToGalleryUseCase {
  const SavePhotoToGalleryUseCase(this._repository);

  final PhoneGalleryRepository _repository;

  Future<Either<SavePhotoToGalleryFailure, Unit>> execute({
    required String path,
  }) =>
      _repository.savePhoto(path: path);
}
