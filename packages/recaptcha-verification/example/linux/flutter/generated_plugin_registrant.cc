//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <recaptcha_verification/recaptcha_verification_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) recaptcha_verification_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RecaptchaVerificationPlugin");
  recaptcha_verification_plugin_register_with_registrar(recaptcha_verification_registrar);
}
