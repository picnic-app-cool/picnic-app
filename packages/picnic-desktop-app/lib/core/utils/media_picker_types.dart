import 'package:file_selector/file_selector.dart';

class MediaPickerTypes {
  static const imagesTypeGroup = XTypeGroup(
    label: 'images',
    extensions: <String>[
      'jpg',
      'png',
      'webp',
      'jpeg',
    ],
  );

  static const videosTypeGroup = XTypeGroup(
    label: 'videos',
    extensions: <String>['mp4', 'mov'],
  );

  static const ducumentsTypeGroup = XTypeGroup(
    label: 'documents',
    extensions: <String>['pdf'],
  );
}
