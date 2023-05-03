import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/model/media_asset.dart';

class FlutterMediaAsset implements MediaAsset {
  FlutterMediaAsset(this.assetEntity);

  final AssetEntity assetEntity;

  @override
  bool get isPhoto => assetEntity.type == AssetType.image;

  @override
  // TODO: implement isVideo
  bool get isVideo => assetEntity.type == AssetType.video;

  @override
  Future<String?> get filePath async => (await assetEntity.originFile)?.path;
}
