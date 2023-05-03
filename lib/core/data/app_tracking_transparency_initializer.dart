import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';

class AppTrackingTransparencyInitializer implements LibraryInitializer {
  @override
  Future<void> init() async {
    // just to make apple happy, we don't use it anyways.
    // if you got to this place to start intentionally using tracking and IFDA, be informed we disabled
    // IFDA support for firebase analytics in Podfile
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}
