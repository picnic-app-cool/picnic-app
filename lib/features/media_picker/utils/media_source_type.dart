import 'package:picnic_app/resources/assets.gen.dart';

//ignore_for_file: no-magic-number
enum MediaSourceType {
  gallery,
  file,
  cameraImage,
  cameraVideo;

  static MediaSourceType from(int index) => MediaSourceType.values.firstWhere((t) => t.index == index);

  String get icon {
    switch (this) {
      case gallery:
        return Assets.images.uploadPhoto.path;
      case file:
        return Assets.images.paper.path;
      case cameraImage:
        return Assets.images.takePhoto.path;
      case cameraVideo:
        return Assets.images.takeVideo.path;
    }
  }
}
