import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/data/assets_loader.dart';
import 'package:picnic_app/core/data/imgly_wrapper.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class ImglyInitializer implements LibraryInitializer {
  ImglyInitializer(
    this.imglyWrapper,
    this.assetsLoader,
  );

  final ImglyWrapper imglyWrapper;
  final AssetsLoader assetsLoader;

  @override
  Future<void> init() async {
    try {
      await _initVideoEditor();
      await _initPhotoEditor();
    } catch (ex, stack) {
      logError(ex, stack: stack);
    }
  }

  Future<void> _initVideoEditor() async {
    final commonPath = await _retrieveCommonPath(
      iosPath: Assets.imgly.vesdkLicenseVideoIos,
      androidPath: Assets.imgly.vesdkLicenseVideoAndroid,
    );
    if (commonPath.isNotEmpty) {
      imglyWrapper.unlockVESDKWithLicense(commonPath);
    }
  }

  Future<void> _initPhotoEditor() async {
    final commonPath = await _retrieveCommonPath(
      iosPath: Assets.imgly.pesdkLicenseIos,
      androidPath: Assets.imgly.pesdkLicenseAndroid,
    );
    if (commonPath.isNotEmpty) {
      imglyWrapper.unlockPESDKWithLicense(commonPath);
    }
  }

  Future<String> _retrieveCommonPath({
    required String iosPath,
    required String androidPath,
  }) async {
    final pathToIosWithoutExtension = iosPath.substring(
      0,
      iosPath.length - Constants.imglyLicenseIosExtension.length,
    );

    final pathToAndroidWithoutExtension = androidPath.substring(
      0,
      androidPath.length - Constants.imglyLicenseAndroidExtension.length,
    );

    if (pathToAndroidWithoutExtension != pathToIosWithoutExtension) {
      throw ArgumentError(
        '''
[iosPath] and [androidPath] must have the same path except for the files extension.
[iosPath] must end with ${Constants.imglyLicenseIosExtension},
[androidPath] must end with ${Constants.imglyLicenseAndroidExtension}.
''',
      );
    }

    final hasIOSLicense = (await assetsLoader.loadString(iosPath)).trim().isNotEmpty;
    final hasAndroidLicense = (await assetsLoader.loadString(androidPath)).trim().isNotEmpty;

    /// for some reason, android app instantly closes if we feed it with incorrect license file,
    /// probably same might happen for iOS, so in case the license files are empty, we simply return the path empty,
    /// to indicate there are no licenses present
    return hasIOSLicense && hasAndroidLicense //
        ? pathToIosWithoutExtension
        : '';
  }
}
