//
//  SceneDelegate.swift
//  sichtbar
//
//  Created by Developer on 28/04/22.
//

import UIKit
import IQKeyboardManagerSwift
import StoreKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate, SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        Thread.sleep(forTimeInterval: 3)
        if !userID.isEmpty{
            if let windowScene = scene as? UIWindowScene {

                self.window = UIWindow(windowScene: windowScene)

                if  ((self.window?.rootViewController) != nil)  {
                    self.window?.rootViewController = nil
                }
                if  let loginNavigationController : UITabBarController = self.getController(name:"TabBarController", storyBoard: homeStoryboard) as? UITabBarController {
                    
                    
                 self.window?.rootViewController = loginNavigationController
                 self.window?.makeKeyAndVisible()
             }
                }

        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        if #available(iOS 13, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        SKPaymentQueue.default().remove(self)
    }


}

extension SceneDelegate {
    func logout(_ view: UIView) {
        DispatchQueue.main.async {
            UserDefaults.NTDefault(removeObjectForKey: kUserId)
            UserDefaults.NTDefault(removeObjectForKey: "nbTimesAppOpened")
            self.setUpLogin(view)
        }
    }
    
    func setUpHome(_ view: UIView)
    {
        if  ((self.window?.rootViewController) != nil)  {
            self.window?.rootViewController = nil
        }
     if  let loginNavigationController : UITabBarController = self.getController(name:"TabBarController",storyBoard: homeStoryboard) as? UITabBarController{
     
         view.window?.rootViewController = loginNavigationController
         //view.window?.makeKeyAndVisible()
     }
}
    private func getController(name identifier : String, storyBoard: UIStoryboard)->UIViewController
    {
        
        let controller:UIViewController = storyBoard.instantiateViewController(withIdentifier: identifier)as UIViewController
        return controller
    }
    
    private func setUpLogin(_ view: UIView)
     {
         if  ((self.window?.rootViewController) != nil)  {
             self.window?.rootViewController = nil
         }
      if  let loginNavigationController : UINavigationController = self.getController(name:"LoginNavigation",storyBoard: mainStoryboard) as? UINavigationController{
      
          view.window?.rootViewController = loginNavigationController
          view.window?.makeKeyAndVisible()
      }
}
   
}
