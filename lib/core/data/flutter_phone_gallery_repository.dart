import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/data/model/flutter_media_asset.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_phone_gallery_assets_failure.dart';
import 'package:picnic_app/core/domain/model/image_watermark_failure.dart';
import 'package:picnic_app/core/domain/model/media_asset.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/save_photo_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/model/save_video_to_gallery_failure.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/core/utils/watermark_image.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class FlutterPhoneGalleryRepository implements PhoneGalleryRepository {
  FlutterPhoneGalleryRepository();

  @override
  Future<Either<GetPhoneGalleryAssetsFailure, PaginatedList<MediaAsset>>> getAssets({
    required Cursor nextPageCursor,
    AssetType? type,
  }) async {
    try {
      final page = nextPageCursor.id == const Id.empty() ? 0 : int.parse(nextPageCursor.id.value);
      final paths = await PhotoManager.getAssetPathList(
        type: _getRequestType(type),
      );
      final allAlbum = paths.firstWhere((element) => element.isAll);

      final entities = await allAlbum.getAssetListPaged(
        page: page,
        size: nextPageCursor.pageSize,
      );
      return success(
        PaginatedList(
          pageInfo: PageInfo(
            nextPageId: Id((page + 1).toString()),
            previousPageId: Id((page - 1).toString()),
            hasNextPage: entities.length == nextPageCursor.pageSize,
            hasPreviousPage: page != 0,
          ),
          items: entities.map((e) => FlutterMediaAsset(e)).toList(),
        ),
      );
    } catch (ex, _) {
      return failure(GetPhoneGalleryAssetsFailure.unknown(ex));
    }
  }

  @override
  Future<Either<SavePhotoToGalleryFailure, Unit>> savePhoto({
    required String path,
  }) async {
    try {
      await PhotoManager.editor.saveImageWithPath(
        path,
        title: basename(path),
      );
      return success(unit);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(SavePhotoToGalleryFailure.unknown(ex));
    }
  }

  @override
  Future<Either<SaveVideoToGalleryFailure, Unit>> saveVideo({
    required String path,
  }) async {
    try {
      final file = File(path);
      await PhotoManager.editor.saveVideo(
        file,
        title: basename(path),
      );
      return success(unit);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(SaveVideoToGalleryFailure.unknown(ex));
    }
  }

  @override
  Future<Either<ImageWatermarkFailure, String>> addImageWatermark({
    required String path,
    required String username,
  }) async {
    try {
      final originalFileWithFixedRotation = await FlutterExifRotation.rotateImage(path: path);
      final watermarkAsset = await rootBundle.load(Assets.images.picnicLogoWithText.path);

      final temporaryDirectory = await getTemporaryDirectory();
      final pathTemporaryFile = File(
        '${temporaryDirectory.path}/$username',
      );
      final watermarkFile = await _getAssetWatermark(pathTemporaryFile, watermarkAsset);

      final originalImage = await WatermarkImage.decodeFileFromIsolate(originalFileWithFixedRotation);
      final watermarkImage = await WatermarkImage.decodeFileFromIsolate(watermarkFile);

      final originalImageWithWatermark = await WatermarkImage(
        originalImage: originalImage,
        watermarkImage: watermarkImage,
        text: username,
      ).addWatermark();

      final orginalFileWithWatermark = File(
        '${temporaryDirectory.path}/watermark${basename(originalFileWithFixedRotation.path)}',
      );

      final file = await WatermarkImage.decodeImageFromIsolate(
        originalImageWithWatermark,
        orginalFileWithWatermark,
      );

      return success(file.path);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(ImageWatermarkFailure.unknown(ex));
    }
  }

  Future<File> _getAssetWatermark(
    File path,
    ByteData watermarkAsset,
  ) {
    return path.writeAsBytes(
      watermarkAsset.buffer.asInt8List(
        watermarkAsset.offsetInBytes,
        watermarkAsset.offsetInBytes + watermarkAsset.lengthInBytes,
      ),
    );
  }

  RequestType _getRequestType(AssetType? assetsType) {
    if (assetsType == null) {
      return RequestType.common;
    }
    switch (assetsType) {
      case AssetType.image:
        return RequestType.image;
      case AssetType.video:
        return RequestType.video;
      case AssetType.other:
      case AssetType.audio:
        return RequestType.common;
    }
  }
}
