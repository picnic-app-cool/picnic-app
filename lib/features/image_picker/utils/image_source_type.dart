import 'package:image_picker/image_picker.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

enum ImageSourceType {
  camera,
  gallery;

  ImageSource get type {
    switch (this) {
      case camera:
        return ImageSource.camera;
      case gallery:
        return ImageSource.gallery;
    }
  }

  String get label {
    switch (this) {
      case camera:
        return appLocalizations.imagePickerAlertOptionCamera;
      case gallery:
        return appLocalizations.imagePickerAlertOptionGallery;
    }
  }

  String get icon {
    switch (this) {
      case camera:
        return Assets.images.cameraSolid.path;
      case gallery:
        return Assets.images.image.path;
    }
  }
}
