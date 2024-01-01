//
//  AppDelegate.swift
//  sichtbar
//
//  Created by Developer on 28/04/22.
//

import UIKit
import AudioToolbox
import FirebaseCore
import Firebase
import StoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name: "SFUIDisplay-Light", size: 17)!], for: UIControl.State.normal)
           
        FirebaseApp.configure()
     
        self.registerApns(application: application)
        return true
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


// MARK:- To Register Apns

extension AppDelegate {
    
    func registerApns(application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            
            UIApplication.shared.delegate = self
            
            UNUserNotificationCenter.current().delegate = self
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                DispatchQueue.main.async {
                    if (granted) {
                        //self.processInitialAPNSRegistration()
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    print("permission granted?: (granted)")
                }
            }
            
            
        }else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    //MARK: Notification Methods-
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        deviceTokenNew = Messaging.messaging().fcmToken ?? ""
        
        Messaging.messaging().token { token, error in
            fcmToken =  token ?? ""
        }
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        deviceTokenNew = token
        print("APNs token retrieved: \(token)")
     }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
}


@available(iOS 10, *)
extension AppDelegate:UNUserNotificationCenterDelegate{
    
    //Called when a notification is delivered to a foreground app.
    
   
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        // create a sound ID, in this case its the tweet sound.
        
        let systemSoundID: SystemSoundID = 1315//1003 // SMSReceived (see SystemSoundID below)
        // to play sound
        AudioServicesPlaySystemSound (systemSoundID)
        
//        if UIApplication.shared.applicationState == .active {
//            let showAction = self.didReceiveRemoteNotification(userAction: false, resRPUsernse: userInfo)
//            if showAction == true {
//                completionHandler([.alert, .badge, .sound])
//            }else{
//                guard let data = notification.request.content.userInfo as? [String:Any] else { return }
//                guard let notitype = data["notItype"] as? Int else { return  }
//
//                if notitype == 11{
//
//                }else{
//                     completionHandler([.alert,.badge, .sound])
//                }
//
//            }
//        }
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        completionHandler([.alert, .sound])
    }
    

    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive resRPUsernse: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = resRPUsernse.notification.request.content.userInfo
        
        
//        if isFromKilled == "2"{
//            isFromKilled = "1"
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//
//                _ =  self.didReceiveRemoteNotification(userAction: true,resRPUsernse: userInfo)
//                   }
//        }else{
//
//                _ =  self.didReceiveRemoteNotification(userAction: true,resRPUsernse: userInfo)
//
//        }
        
        
      
        completionHandler()
    }
}
