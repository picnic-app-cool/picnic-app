import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin GetVideoRoute {
  Future<File?> getVideo(ImageSourceType imageSourceType) async {
    final _picker = ImagePicker();
    XFile? _videoFile;
    final selectedVideo = await _picker.pickVideo(
      source: imageSourceType.type,
    );
    if (selectedVideo != null) {
      _videoFile = selectedVideo;

      final videoFilePath = File(_videoFile.path);

      return videoFilePath;
    }
    return null;
  }

  AppNavigator get appNavigator;
}
