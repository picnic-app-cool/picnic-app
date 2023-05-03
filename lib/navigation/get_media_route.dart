import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin GetMediaRoute {
  Future<File?> getImageVideo(MediaSourceType sourceType) async {
    final _picker = ImagePicker();
    XFile? _imageFile;

    late final XFile? selectedImage;

    switch (sourceType) {
      case MediaSourceType.cameraImage:
        selectedImage = await _picker.pickImage(source: ImageSource.camera);
        break;
      case MediaSourceType.cameraVideo:
        selectedImage = await _picker.pickVideo(source: ImageSource.camera);
        break;
      case MediaSourceType.gallery:
        selectedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          requestFullMetadata: false,
        );
        break;
      case MediaSourceType.file:
        break;
    }

    if (selectedImage != null) {
      _imageFile = selectedImage;

      final imageFilePath = File(_imageFile.path);

      return imageFilePath;
    }
    return null;
  }

  Future<List<File>> getPdfFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result != null ? result.paths.whereType<String>().map((path) => File(path)).toList() : [];
  }

  AppNavigator get appNavigator;
}
