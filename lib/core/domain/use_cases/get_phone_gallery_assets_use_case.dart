import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_phone_gallery_assets_failure.dart';
import 'package:picnic_app/core/domain/model/media_asset.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';

class GetPhoneGalleryAssetsUseCase {
  const GetPhoneGalleryAssetsUseCase(this._repository);

  final PhoneGalleryRepository _repository;

  Future<Either<GetPhoneGalleryAssetsFailure, PaginatedList<MediaAsset>>> execute({
    required Cursor nextPageCursor,
  }) =>
      _repository.getAssets(nextPageCursor: nextPageCursor);
}
