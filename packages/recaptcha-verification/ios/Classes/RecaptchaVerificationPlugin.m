#import "RecaptchaVerificationPlugin.h"
#if __has_include(<recaptcha_verification/recaptcha_verification-Swift.h>)
#import <recaptcha_verification/recaptcha_verification-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "recaptcha_verification-Swift.h"
#endif

@implementation RecaptchaVerificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRecaptchaVerificationPlugin registerWithRegistrar:registrar];
}
@end
