package zone.picnic.recaptcha_verification.webview

import android.annotation.SuppressLint
import android.content.DialogInterface
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.setFragmentResult
import zone.picnic.recaptcha_verification.R

class WebviewFragment : DialogFragment() {

    private val webView by lazy(LazyThreadSafetyMode.NONE) {
        requireView().findViewById<WebView>(R.id.webview)
    }

    private val url by lazy(LazyThreadSafetyMode.NONE) {
        arguments?.getString(EXTRA_URL) ?: ""
    }

    private val uriFragment by lazy(LazyThreadSafetyMode.NONE) {
        arguments?.getString(EXTRA_TARGET_URI_FRAGMENT) ?: ""
    }

    private val webViewWidth by lazy(LazyThreadSafetyMode.NONE) {
        if (arguments?.containsKey(EXTRA_WIDTH) == false) return@lazy null

        arguments?.getInt(EXTRA_WIDTH)
    }

    private val webViewHeight by lazy(LazyThreadSafetyMode.NONE) {
        if (arguments?.containsKey(EXTRA_HEIGHT) == false) return@lazy null

        arguments?.getInt(EXTRA_HEIGHT)
    }

    private var token = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, 0);
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = inflater.inflate(R.layout.webview_fragment, container, false)

    override fun onStart() {
        super.onStart()
        val (width, height) = webViewWidth to webViewHeight

        if (width != null && height != null) {
            dialog?.window?.setLayout(width, height)
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        webView.settings.apply {
            @SuppressLint("SetJavaScriptEnabled")
            javaScriptEnabled = true
            javaScriptCanOpenWindowsAutomatically = true
        }
        webView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                if (url.contains(uriFragment)) {
                    token = Uri.parse(url).getQueryParameters(uriFragment).first()
                    dismiss()
                }
                return false
            }
        }
        webView.loadUrl(url)
    }

    override fun onDismiss(dialog: DialogInterface) {
        super.onDismiss(dialog)
        setFragmentResult(
            RESULT_KEY,
            Bundle().apply {
                putBoolean(RESULT_EXTRA_STATUS_KEY, token.isNotEmpty())
                putString(RESULT_EXTRA_ID_KEY, token)
            }
        )
    }

    companion object {
        private const val EXTRA_URL = "picnic.WebviewFragment.EXTRA_URL"
        private const val EXTRA_TARGET_URI_FRAGMENT =
            "picnic.WebviewFragment.EXTRA_TARGET_URI_FRAGMENT"
        private const val EXTRA_WIDTH = "picnic.WebviewFragment.EXTRA_WIDTH"
        private const val EXTRA_HEIGHT = "picnic.WebviewFragment.EXTRA_HEIGHT"

        const val RESULT_KEY = "picnic.WebviewFragment.RESULT_KEY"
        const val RESULT_EXTRA_STATUS_KEY = "picnic.WebviewFragment.RESULT_EXTRA_STATUS_KEY"
        const val RESULT_EXTRA_ID_KEY = "picnic.WebviewFragment.RESULT_EXTRA_ID_KEY"

        fun newInstance(
            url: String,
            targetUriFragment: String,
            width: Int?,
            height: Int?
        ) =
            WebviewFragment().apply {
                arguments = Bundle().apply {
                    putString(EXTRA_URL, url)
                    putString(EXTRA_TARGET_URI_FRAGMENT, targetUriFragment)
                    if (width != null) {
                        putInt(EXTRA_WIDTH, width)
                    }
                    if (height != null) {
                        putInt(EXTRA_HEIGHT, height)
                    }
                }
            }
    }
}