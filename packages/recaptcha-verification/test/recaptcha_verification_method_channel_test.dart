import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recaptcha_verification/recaptcha_verification_method_channel.dart';

void main() {
  MethodChannelRecaptchaVerification platform = MethodChannelRecaptchaVerification();
  const MethodChannel channel = MethodChannel('recaptcha_verification');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
