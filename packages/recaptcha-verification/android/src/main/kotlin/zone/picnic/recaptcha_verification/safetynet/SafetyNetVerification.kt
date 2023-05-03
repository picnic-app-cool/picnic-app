package zone.picnic.recaptcha_verification.safetynet

import android.content.Context
import android.util.Log
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.safetynet.SafetyNet

private const val LOG_TAG = "SafetyNetVerification"

class SafetyNetVerification {
    fun verify(
        context: Context,
        siteKey: String,
        onSuccess: (String) -> Unit,
        onError: (Throwable) -> Unit
    ) {
        SafetyNet.getClient(context)
            .verifyWithRecaptcha(siteKey)
            .addOnSuccessListener { response ->
                val token = response?.tokenResult
                Log.d(LOG_TAG, "Verification token = $token")

                if (token?.isNotEmpty() == true) {
                    onSuccess(token)
                } else {
                    onError(IllegalStateException("There is no token"))
                }
            }
            .addOnFailureListener { e ->
                if (e is ApiException) {
                    Log.d(
                        LOG_TAG,
                        "Error: ${CommonStatusCodes.getStatusCodeString(e.statusCode)}"
                    )
                } else {
                    // below line is use to display a toast message for any error.
                    Log.d(LOG_TAG, "Error: $e")
                }
                onError(e)
            }
            .addOnCanceledListener {
                Log.d(LOG_TAG, "Verification was cancelled")
                onError(IllegalStateException("User cancelled"))
            }
    }
}