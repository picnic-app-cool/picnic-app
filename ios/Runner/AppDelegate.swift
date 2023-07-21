import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
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
