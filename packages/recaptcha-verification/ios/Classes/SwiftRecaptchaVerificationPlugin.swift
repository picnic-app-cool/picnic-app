import Flutter
import UIKit
import Foundation

public class SwiftRecaptchaVerificationPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "recaptcha_verification", binaryMessenger: registrar.messenger())
        let instance = SwiftRecaptchaVerificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! NSDictionary
        switch call.method {
        case "recaptchaVerification":
            let type = args["type"] as! String
            if (type == "webview") {
                let url = args["url"] as! String
                let targetUriFragment = args["targetUriFragment"] as! String
                
                webviewRecaptcha(
                    url: url,
                    targetUriFragment: targetUriFragment,
                    width: 600,
                    height: 600,
                    result: result
                )
            } else {
                result(FlutterError(code: "",
                                    message: "Unsupported type",
                                    details: "" ))
            }
            break;
        default:
            break;
        }
    }
    
    func webviewRecaptcha(url: String,
                          targetUriFragment: String,
                          width: CGFloat?,
                          height: CGFloat?,
                          result: @escaping FlutterResult) {
        let appWindow = UIApplication.shared.windows.first!
        let webviewController = WebviewController()
        
        webviewController.targetUriFragment = targetUriFragment
        webviewController.width = width
        webviewController.height = height
        
        var isResultHandled = false
        
        webviewController.onComplete = { (callbackUrl) -> Void in
            if (!isResultHandled) {
                isResultHandled = true
                let queryItems = URLComponents(string: callbackUrl ?? "")?.queryItems
                let token = queryItems?.filter({$0.name == targetUriFragment}).first
                if (token == nil) {
                    result(FlutterError(code: "",
                                        message: "There is no token",
                                        details: "" ))
                }
                result(token?.value)
            }
        }
        
        webviewController.onDismissed = { () -> Void in
            if (!isResultHandled){
                
                isResultHandled = true
                result(result(FlutterError(code: "",
                                           message: "User cancelled",
                                           details: "" )))
            }
        }
        
        webviewController.loadUrl(url)
        appWindow.rootViewController?.present(webviewController, animated: false)
    }
}
