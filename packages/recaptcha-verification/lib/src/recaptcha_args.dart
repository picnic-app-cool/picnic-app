import 'package:recaptcha_verification/src/recaptcha_type.dart';

class RecaptchaArgs {
  // reCAPTCHA v2 - reCAPTCHA Android
  const RecaptchaArgs.android({required this.siteKey})
      : url = '',
        type = RecaptchaType.android,
        _targetUriFragment = '',
        width = null,
        height = null;

  // reCAPTCHA v2 - Invisible reCAPTCHA badge
  const RecaptchaArgs.iOS({required this.siteKey})
      : url = '',
        type = RecaptchaType.ios,
        _targetUriFragment = '',
        width = null,
        height = null;

  // reCAPTCHA v2 - "I'm not a robot" Checkbox
  const RecaptchaArgs.webview({
    required this.siteKey,
    this.url = '',
    this.width,
    this.height,
  })  : type = RecaptchaType.webview,
        _targetUriFragment = 'response';

  final String siteKey;
  final RecaptchaType type;
  final String url;
  final String _targetUriFragment;
  final int? width;
  final int? height;

  Map<String, String> toJson() => {
        'siteKey': siteKey,
        'url': url,
        'type': type.type,
        'targetUriFragment': _targetUriFragment,
        if (width != null) 'width': width.toString(),
        if (height != null) 'height': height.toString(),
      };
}
