import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_desktop_app/core/utils/media_picker_types.dart';

class DesktopImagePickerNavigator extends ImagePickerNavigator {
  DesktopImagePickerNavigator(super.appNavigator);

  @override
  Future<File?> getImage(ImageSourceType imageSourceType) async {
    final selectedImage = await openFile(
      acceptedTypeGroups: <XTypeGroup>[MediaPickerTypes.imagesTypeGroup],
    ).onError((error, stackTrace) {
      debugLog(error.toString());
      return null;
    });

    if (selectedImage != null) {
      return File(selectedImage.path);
    }
    return null;
  }
}
