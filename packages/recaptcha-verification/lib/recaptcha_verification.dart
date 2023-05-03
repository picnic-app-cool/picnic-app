import 'package:recaptcha_verification/recaptcha_verification.dart';
import 'package:recaptcha_verification/src/recaptcha_type.dart';

import 'recaptcha_verification_platform_interface.dart';

export 'package:recaptcha_verification/src/recaptcha_args.dart';
export 'package:recaptcha_verification/src/webview/recaptcha_html.dart';
export 'package:recaptcha_verification/src/webview/recaptcha_verification_server.dart';

class RecaptchaVerification {
  Future<String?> getPlatformVersion() {
    return RecaptchaVerificationPlatform.instance.getPlatformVersion();
  }

  Future<String> repcaptchaVerification(RecaptchaArgs args) async {
    switch (args.type) {
      case RecaptchaType.webview:
        final server = RecaptchaVerificationServer(args.siteKey);
        await server.start();

        return RecaptchaVerificationPlatform.instance //
            .repcaptchaVerification(
              RecaptchaArgs.webview(
                siteKey: args.siteKey,
                url: server.url,
                width: args.width,
                height: args.height,
              ),
            )
            .whenComplete(() => server.close());
      case RecaptchaType.ios:
      case RecaptchaType.android:
        return RecaptchaVerificationPlatform.instance.repcaptchaVerification(args);
    }
  }
}
