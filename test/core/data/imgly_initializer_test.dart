import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/imgly_initializer.dart';
import 'package:picnic_app/resources/assets.gen.dart';

import '../../mocks/mocks.dart';

Future<void> main() async {
  test(
    "should not initialize PESDK library",
    () async {
      //GIVEN
      final initializer = ImglyInitializer(
        Mocks.imglyWrapper,
        Mocks.assetsLoader,
      );
      _mockLicenseFileFor([
        Assets.imgly.vesdkLicenseVideoIos,
        Assets.imgly.vesdkLicenseVideoAndroid,
      ]);

      //WHEN
      await initializer.init();

      //THEN
      verifyNever(() => Mocks.imglyWrapper.unlockPESDKWithLicense(any()));
      verify(() => Mocks.imglyWrapper.unlockVESDKWithLicense(any()));
    },
  );
  test(
    "should not initialize any libraries",
    () async {
      //GIVEN
      final initializer = ImglyInitializer(
        Mocks.imglyWrapper,
        Mocks.assetsLoader,
      );
      _mockLicenseFileFor([]);

      //WHEN
      await initializer.init();

      //THEN
      verifyNever(() => Mocks.imglyWrapper.unlockPESDKWithLicense(any()));
      verifyNever(() => Mocks.imglyWrapper.unlockVESDKWithLicense(any()));
    },
  );
  test(
    "should initialize both libraries",
    () async {
      //GIVEN
      final initializer = ImglyInitializer(
        Mocks.imglyWrapper,
        Mocks.assetsLoader,
      );
      _mockLicenseFileFor([
        Assets.imgly.vesdkLicenseVideoIos,
        Assets.imgly.vesdkLicenseVideoAndroid,
        Assets.imgly.pesdkLicenseIos,
        Assets.imgly.pesdkLicenseAndroid,
      ]);

      //WHEN
      await initializer.init();

      //THEN
      verify(() => Mocks.imglyWrapper.unlockPESDKWithLicense(any()));
      verify(() => Mocks.imglyWrapper.unlockVESDKWithLicense(any()));
    },
  );
}

void _mockLicenseFileFor(List<String> filesToBePresent) {
  when(
    () => Mocks.assetsLoader.loadString(any()),
  ).thenAnswer((invo) {
    final path = invo.positionalArguments[0] as String;
    if (filesToBePresent.contains(path)) {
      return Future.value("super awesome license file contents here");
    } else {
      return Future.value("");
    }
  });
}
