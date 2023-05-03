//ignore_for_file: forbidden_import_in_domain
import 'package:dartz/dartz.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_phone_gallery_assets_failure.dart';
import 'package:picnic_app/core/domain/model/media_asset.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/media_picker/domain/model/media_picker_file_type.dart';

class GetAttachmentsUseCase {
  const GetAttachmentsUseCase(this._repository);

  final PhoneGalleryRepository _repository;

  Future<Either<GetPhoneGalleryAssetsFailure, PaginatedList<Attachment>>> execute({
    required Cursor nextPageCursor,
    AssetType? type,
  }) =>
      _repository.getAssets(nextPageCursor: nextPageCursor, type: type).mapSuccessAsync(_toAttachments);

  Future<PaginatedList<Attachment>> _toAttachments(PaginatedList<MediaAsset> mediaAssets) {
    return mediaAssets.mapNotNullItemsAsync(_toAttachment);
  }

  Future<Attachment?> _toAttachment(MediaAsset mediaAsset) async {
    final fileType = mediaAsset.isPhoto ? MediaPickerFileType.image : MediaPickerFileType.video;
    final filePath = await mediaAsset.filePath;
    return filePath != null
        ? const Attachment.empty().copyWith(
            url: filePath,
            fileType: fileType.mimeType,
          )
        : null;
  }
}
