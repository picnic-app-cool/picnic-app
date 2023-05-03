//ignore_for_file: forbidden_import_in_domain
import 'package:dartz/dartz.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_phone_gallery_assets_failure.dart';
import 'package:picnic_app/core/domain/model/image_watermark_failure.dart';
import 'package:picnic_app/core/domain/model/media_asset.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/save_photo_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/model/save_video_to_gallery_failure.dart';

abstract class PhoneGalleryRepository {
  //TODO Wrap AssetsType and avoid passing photo manager dependecies here https://picnic-app.atlassian.net/browse/GS-7731
  Future<Either<GetPhoneGalleryAssetsFailure, PaginatedList<MediaAsset>>> getAssets({
    required Cursor nextPageCursor,
    AssetType? type,
  });

  Future<Either<SavePhotoToGalleryFailure, Unit>> savePhoto({
    required String path,
  });

  Future<Either<SaveVideoToGalleryFailure, Unit>> saveVideo({
    required String path,
  });

  /// Add watermark in an image
  /// The [path] is the path of original image and will receive the waternark
  /// The [username] is a text that will be displayed in the bottom of watermark image
  Future<Either<ImageWatermarkFailure, String>> addImageWatermark({
    required String path,
    required String username,
  });
}
