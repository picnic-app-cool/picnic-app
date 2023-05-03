package zone.picnic.recaptcha_verification

import io.flutter.plugin.common.MethodCall

sealed class RecaptchaArgs {
    companion object {
        fun fromCall(call: MethodCall): RecaptchaArgs {
            when (call.argument<String>("type")) {
                "webview" -> {
                    val url = call.argument<String>("url")
                        ?: throw IllegalStateException("No url")
                    val targetUrlFragment = call.argument<String>("targetUriFragment")
                        ?: throw IllegalStateException("No target uri fragment")
                    val width = call.argument<String>("width")?.toIntOrNull()
                    val height = call.argument<String>("height")?.toIntOrNull()

                    return WebView(url, targetUrlFragment, width, height)
                }
                "android" -> {
                    val siteKey = call.argument<String>("siteKey")
                        ?: throw IllegalStateException("No site key")

                    return SafetyNet(siteKey)
                }
                else -> throw IllegalStateException("Unknown captcha type")
            }
        }
    }

    data class SafetyNet(val siteKey: String) : RecaptchaArgs()
    data class WebView(
        val url: String,
        val targetUriFragment: String,
        val width: Int?,
        val height: Int?
    ) : RecaptchaArgs()
}
