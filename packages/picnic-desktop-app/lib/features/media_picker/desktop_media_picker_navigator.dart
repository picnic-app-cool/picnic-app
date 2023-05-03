import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:picnic_app/features/media_picker/media_picker_navigator.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';
import 'package:picnic_desktop_app/core/utils/media_picker_types.dart';

class DesktopMediaPickerNavigator extends MediaPickerNavigator {
  DesktopMediaPickerNavigator(super.appNavigator);

  @override
  Future<File?> getImageVideo(MediaSourceType sourceType) async {
    late final XFile? selectedImage;

    switch (sourceType) {
      case MediaSourceType.gallery:
        selectedImage = await openFile(
          acceptedTypeGroups: <XTypeGroup>[
            MediaPickerTypes.imagesTypeGroup,
            MediaPickerTypes.videosTypeGroup,
          ],
        );
        break;
      case MediaSourceType.cameraImage:
      case MediaSourceType.cameraVideo:
      case MediaSourceType.file:
        break;
    }

    if (selectedImage != null) {
      final imageFilePath = File(selectedImage.path);

      return imageFilePath;
    }
    return null;
  }
}
