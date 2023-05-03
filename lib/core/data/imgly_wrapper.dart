import 'package:photo_editor_sdk/photo_editor_sdk.dart';
import 'package:video_editor_sdk/video_editor_sdk.dart';

class ImglyWrapper {
  void unlockVESDKWithLicense(String commonPath) => VESDK.unlockWithLicense(commonPath);

  void unlockPESDKWithLicense(String commonPath) => PESDK.unlockWithLicense(commonPath);
}
