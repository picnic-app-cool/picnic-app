import 'package:flutter_test/flutter_test.dart';
import 'package:recaptcha_verification/recaptcha_verification.dart';
import 'package:recaptcha_verification/recaptcha_verification_platform_interface.dart';
import 'package:recaptcha_verification/recaptcha_verification_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRecaptchaVerificationPlatform with MockPlatformInterfaceMixin implements RecaptchaVerificationPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RecaptchaVerificationPlatform initialPlatform = RecaptchaVerificationPlatform.instance;

  test('$MethodChannelRecaptchaVerification is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRecaptchaVerification>());
  });

  test('getPlatformVersion', () async {
    RecaptchaVerification recaptchaVerificationPlugin = RecaptchaVerification();
    MockRecaptchaVerificationPlatform fakePlatform = MockRecaptchaVerificationPlatform();
    RecaptchaVerificationPlatform.instance = fakePlatform;

    expect(await recaptchaVerificationPlugin.getPlatformVersion(), '42');
  });
}
