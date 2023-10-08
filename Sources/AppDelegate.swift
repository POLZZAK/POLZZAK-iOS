//
//  AppDelegate.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/05/11.
//

import UIKit
import UserNotifications

import Firebase
import FirebaseMessaging
import KakaoSDKCommon
import SharedResources

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeKakaoSDK()
        checkFirstLaunch()
        initializeFirebase()
        registerFont()
        
        setupNotifications(for: application)
        
        return true
    }
    
    // MARK: Initialization
        private func initializeKakaoSDK() {
            KakaoSDK.initSDK(appKey: Constants.KakaoKey.nativeAppKey)
        }
        
        private func checkFirstLaunch() {
            UserInfoManager.checkFirstLaunch()
        }
        
        private func initializeFirebase() {
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
        }
        
        private func registerFont() {
            UIFont.registerFont()
        }
        
        private func setupNotifications(for application: UIApplication) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { granted, error in
                    if let error = error {
                        print("Error requesting authorization: \(error)")
                        return
                    }
                    
                    if granted {
                        DispatchQueue.main.async {
                            application.registerForRemoteNotifications()
                        }
                    }
                }
            )
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken: \(fcmToken)")
    }
}
