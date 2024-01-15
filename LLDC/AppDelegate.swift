//
//  AppDelegate.swift
//  LLDC
//
//  Created by Emojiios on 28/03/2022.
//

import UIKit
import Firebase
import GoogleMaps
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable  {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    static let PostNotification = NSNotification.Name(rawValue: "Notification")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        LodBaseUrl()
    
        let ControllerNav = UINavigationController(rootViewController: LaunchScreen())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        ControllerNav.navigationBar.isHidden = true
        window?.rootViewController = ControllerNav
        
        MOLH.shared.activate(true)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .black
        IQKeyboardManager.shared.toolbarBarTintColor = .white
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localizable
        
        //
        UIImageView.appearance().isExclusiveTouch = true
        UILabel.appearance().isExclusiveTouch = true
        UIView.appearance().isExclusiveTouch = true
        UIButton.appearance().isExclusiveTouch = true
        
        // Notifications config
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in })
        } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        // Google Maps
        GMSServices.provideAPIKey("AIzaSyBrYm-OC_drHU2IYlUwDKoW500cNvBNNCQ")
        return true
    }
    
    func reset() {
    FirstController(LaunchScreen())
    IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localizable
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
        print(userInfo)
      }

      // [START receive_message]
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
      }
      // [END receive_message]
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
      }
    
      func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
      }

}

extension AppDelegate : UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
        
    NotificationCenter.default.post(name: AppDelegate.PostNotification, object: nil)
    }
    if #available(iOS 14.0, *) {
        completionHandler([.banner, .sound])
    } else {
        completionHandler([[.alert, .sound]])
    }
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    print(userInfo)
    completionHandler()
  }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
  // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")
    defaults.set(fcmToken, forKey: "fireToken")
    }
    
  }
  


