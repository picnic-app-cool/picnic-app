import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:recaptcha_verification/src/recaptcha_args.dart';

import 'recaptcha_verification_method_channel.dart';

abstract class RecaptchaVerificationPlatform extends PlatformInterface {
  /// Constructs a RecaptchaVerificationPlatform.
  RecaptchaVerificationPlatform() : super(token: _token);

  static final Object _token = Object();

  static RecaptchaVerificationPlatform _instance = MethodChannelRecaptchaVerification();

  /// The default instance of [RecaptchaVerificationPlatform] to use.
  ///
  /// Defaults to [MethodChannelRecaptchaVerification].
  static RecaptchaVerificationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RecaptchaVerificationPlatform] when
  /// they register themselves.
  static set instance(RecaptchaVerificationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> repcaptchaVerification(RecaptchaArgs args) {
    throw UnimplementedError('repcatchaVerification(args) has not been implemented.');
  }
}
