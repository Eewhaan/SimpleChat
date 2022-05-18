//
//  AppDelegate.swift
//  simpleChat
//
//  Created by Ivan Pavic on 4.3.22..
//

import UIKit
import SendBirdSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let APP_ID = "F04D5AF2-6D2C-41A7-B8D6-C904543111AD"
        SBDMain.initWithApplicationId(APP_ID, useCaching: false) {
            
        } completionHandler: { error in
            // code to inform user if he is connected to server
        }
        
        if let userID = UIDevice.current.identifierForVendor?.uuidString {
            SBDMain.connect(withUserId: userID) { user, error in
            guard let user = user, error == nil else { return }
            }
        }
        
        
        
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

