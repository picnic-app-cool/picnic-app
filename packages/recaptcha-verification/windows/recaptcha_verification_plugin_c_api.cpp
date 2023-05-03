#include "include/recaptcha_verification/recaptcha_verification_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "recaptcha_verification_plugin.h"

void RecaptchaVerificationPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  recaptcha_verification::RecaptchaVerificationPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
