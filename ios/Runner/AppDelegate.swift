import UIKit
import Flutter
import ImglyKit
import Firebase

// used by Img.ly to set up icon in the editor to specific size
private extension UIImage {
  func icon(pt: CGFloat, alpha: CGFloat = 1) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: pt, height: pt), false, scale)
    let position = CGPoint(x: (pt - size.width) / 2, y: ((pt - size.height) / 2) + 3)
    draw(at: position, blendMode: .normal, alpha: alpha)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    configureEditorIcons()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // https://support.img.ly/hc/en-us/articles/7772957651729-Can-I-customize-the-export-button- 
  func configureEditorIcons() -> Void {
    let config = UIImage.SymbolConfiguration(scale: .large)

    IMGLY.bundleImageBlock = { imageName in
      switch imageName {
        case "imgly_icon_save":
          return UIImage(systemName: "paperplane.fill", withConfiguration: config)?.icon(pt: 44, alpha: 0.6)

        default:
          return nil
      }
    }
  }

    // This is a hacky fix to overcome an issue with Firebase auth. Currently, our Notification Extension
    // that handles images in notification is somehow disabling handling push notifications by Firebase Auth. to
    // overcome this issue, we manually forward notification to Firebase Auth.
    override func application(
    _ application: UIApplication,
      didReceiveRemoteNotification notification: [AnyHashable : Any],
      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
      ) {
          
    if Auth.auth().canHandleNotification(notification) {
      completionHandler(.noData)
      return
    }
    // This notification is not auth related; it should be handled separately.

    return super.application(application, didReceiveRemoteNotification: notification, fetchCompletionHandler: completionHandler)

  }
}
