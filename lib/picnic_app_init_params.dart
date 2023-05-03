import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/environment_config/debug_environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/prod_environment_config_provider.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';

class PicnicAppInitParams {
  const PicnicAppInitParams({
    required this.showDebugScreen,
    required this.featureFlagsDefaults,
    required this.environmentConfigProvider,
    required this.devicePlatformProvider,
  });

  factory PicnicAppInitParams.mobile(
    DevicePlatformProvider devicePlatformProvider,
  ) {
    const featureFlagsDefaults = FeatureFlagsDefaults();

    return PicnicAppInitParams(
      showDebugScreen: _showDebugScreen,
      featureFlagsDefaults: featureFlagsDefaults,
      environmentConfigProvider: _buildEnvConfigProvider(featureFlagsDefaults),
      devicePlatformProvider: devicePlatformProvider,
    );
  }
  factory PicnicAppInitParams.desktop(
    DevicePlatformProvider devicePlatformProvider,
  ) {
    final featureFlagsDefaults = FeatureFlagsDefaults(
      overridenFlags: {
        FeatureFlagType.isFirebasePhoneAuthEnabled: false,
        // macOS apps distributed outside of app store cannot support sign in with apple
        // https://developer.apple.com/forums/thread/671319
        FeatureFlagType.signInWithAppleEnabled: false,
        FeatureFlagType.chatInputAttachmentEnabled: false,
        FeatureFlagType.chatInputElectricEnabled: false,
        FeatureFlagType.attachmentNativePicker: true,
        // enable sign in with google when https://pub.dev/packages/firebase_auth starts
        // supporting Windows platform
        FeatureFlagType.signInWithGoogleEnabled: devicePlatformProvider.currentPlatform != DevicePlatform.windows,
      },
    );

    return PicnicAppInitParams(
      showDebugScreen: _showDebugScreen,
      featureFlagsDefaults: featureFlagsDefaults,
      environmentConfigProvider: _buildEnvConfigProvider(featureFlagsDefaults),
      devicePlatformProvider: devicePlatformProvider,
    );
  }

  factory PicnicAppInitParams.defaultForPlatform() {
    final devicePlatformProvider = DevicePlatformProvider();
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return PicnicAppInitParams.mobile(devicePlatformProvider);
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return PicnicAppInitParams.desktop(devicePlatformProvider);
    }
  }

  final bool showDebugScreen;
  final FeatureFlagsDefaults featureFlagsDefaults;
  final EnvironmentConfigProvider environmentConfigProvider;
  final DevicePlatformProvider devicePlatformProvider;

  static bool get _showDebugScreen => !kReleaseMode;

  static EnvironmentConfigProvider _buildEnvConfigProvider(FeatureFlagsDefaults featureFlagsDefaults) {
    return _showDebugScreen
        ? DebugEnvironmentConfigProvider(featureFlagsDefaults)
        : ProdEnvironmentConfigProvider(featureFlagsDefaults);
  }
}
