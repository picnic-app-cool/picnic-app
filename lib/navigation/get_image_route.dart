import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin GetImageRoute {
  Future<File?> getImage(ImageSourceType imageSourceType) async {
    final _picker = ImagePicker();
    final selectedImage = await _picker
        .pickImage(
      source: imageSourceType.type,
    )
        .onError((error, stackTrace) {
      debugLog(error.toString());
      return null;
    });

    if (selectedImage != null) {
      return FlutterExifRotation.rotateImage(path: selectedImage.path);
    }
    return null;
  }

  AppNavigator get appNavigator;
}
