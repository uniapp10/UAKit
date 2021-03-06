//
//  AppDelegate.swift
//  UAKitBase
//
//  Created by ZD on 2020/3/17.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import UAKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13,*) {
            print("ios13")
        } else {
            UANavigatorMap.initialize(navigator: navigator)
            let vc = UATableVC()
//            let vc = UASplashVC()
            let nav = UABaseNavC(rootViewController: vc)
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.backgroundColor = .white
            window?.rootViewController = nav
            
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        print(options)
        print(url.scheme)
        print(url.query)
        
        let params_1 = options[UIApplication.OpenURLOptionsKey.sourceApplication]
        let params = options[UIApplication.OpenURLOptionsKey.annotation]
        print(params_1)
        print(params)
        let view = UIAlertView(title: url.scheme, message: url.query, delegate: nil, cancelButtonTitle: "ok")
        view.show()
        return false
    }
    
//    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
//        return false
//    }

}

@available(iOS 13.0, *)
extension AppDelegate {
    
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

