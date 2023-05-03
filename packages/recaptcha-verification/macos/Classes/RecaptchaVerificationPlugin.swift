import Cocoa
import FlutterMacOS
import Foundation
import WebKit

public class RecaptchaVerificationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "recaptcha_verification", binaryMessenger: registrar.messenger)
    let instance = RecaptchaVerificationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "recaptchaVerification":
        let args = call.arguments as! NSDictionary
        
        let url = args["url"] as! String
        let targetUriFragment = args["targetUriFragment"] as! String

        webviewRecaptcha(
            url: url,
            targetUriFragment: targetUriFragment,
            width: 600,
            height: 600,
            result: result
        )
        
        break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    func webviewRecaptcha(url: String,
                         targetUriFragment: String,
                         width: CGFloat?,
                         height: CGFloat?,
                         result: @escaping FlutterResult) {
        let appWindow = NSApplication.shared.windows.first!
        let webviewController = WebviewController()
        
        webviewController.targetUriFragment = targetUriFragment
        webviewController.width = width
        webviewController.height = height

        webviewController.onComplete = { (callbackUrl) -> Void in
            let queryItems = URLComponents(string: callbackUrl ?? "")?.queryItems
            let token = queryItems?.filter({$0.name == targetUriFragment}).first
            
            result(token?.value)
        }
        
        webviewController.onDismissed = { () -> Void in
            
        }

        webviewController.loadUrl(url)
        appWindow.contentViewController?.presentAsModalWindow(webviewController)
    }
}
