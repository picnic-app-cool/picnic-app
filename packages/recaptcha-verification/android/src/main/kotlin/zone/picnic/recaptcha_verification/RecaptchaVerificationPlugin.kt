package zone.picnic.recaptcha_verification

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import androidx.fragment.app.setFragmentResultListener
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import zone.picnic.recaptcha_verification.safetynet.SafetyNetVerification
import zone.picnic.recaptcha_verification.webview.WebviewFragment

class RecaptchaVerificationPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var appContext: Context
    private var activity: Activity? = null

    private val safetyNetVerification = SafetyNetVerification()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        appContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "recaptcha_verification")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "recaptchaVerification" -> {
                when (val args = RecaptchaArgs.fromCall(call)) {
                    is RecaptchaArgs.SafetyNet -> openSafetyNetRecaptcha(args, result)
                    is RecaptchaArgs.WebView -> openWebViewRecaptcha(args, result)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun openSafetyNetRecaptcha(args: RecaptchaArgs.SafetyNet, result: Result) {
        safetyNetVerification.verify(
            context = appContext,
            siteKey = args.siteKey,
            onSuccess = result::success
        ) {
            result.error("", it.message, "")
        }
    }

    private fun openWebViewRecaptcha(args: RecaptchaArgs.WebView, result: Result) {
        val fragment = WebviewFragment
            .newInstance(args.url, args.targetUriFragment, args.width, args.height)

        fragment.show((activity as FlutterFragmentActivity).supportFragmentManager, null)
        fragment.setFragmentResultListener(WebviewFragment.RESULT_KEY) { _, bundle ->
            val isSuccessful = bundle.getBoolean(WebviewFragment.RESULT_EXTRA_STATUS_KEY, false)

            if (isSuccessful) {
                val token = bundle.getString(WebviewFragment.RESULT_EXTRA_ID_KEY)
                result.success(token)
            } else {
                result.error("", "", "")
            }
        }
    }
}
