#ifndef FLUTTER_PLUGIN_RECAPTCHA_VERIFICATION_PLUGIN_H_
#define FLUTTER_PLUGIN_RECAPTCHA_VERIFICATION_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace recaptcha_verification {

class RecaptchaVerificationPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  RecaptchaVerificationPlugin();

  virtual ~RecaptchaVerificationPlugin();

  // Disallow copy and assign.
  RecaptchaVerificationPlugin(const RecaptchaVerificationPlugin&) = delete;
  RecaptchaVerificationPlugin& operator=(const RecaptchaVerificationPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace recaptcha_verification

#endif  // FLUTTER_PLUGIN_RECAPTCHA_VERIFICATION_PLUGIN_H_
