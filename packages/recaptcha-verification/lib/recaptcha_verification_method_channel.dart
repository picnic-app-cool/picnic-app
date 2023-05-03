import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:recaptcha_verification/src/recaptcha_args.dart';

import 'recaptcha_verification_platform_interface.dart';

/// An implementation of [RecaptchaVerificationPlatform] that uses method channels.
class MethodChannelRecaptchaVerification extends RecaptchaVerificationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('recaptcha_verification');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> repcaptchaVerification(RecaptchaArgs args) async {
    return await methodChannel.invokeMethod<String>('recaptchaVerification', args.toJson()) ?? 'No token';
  }
}
