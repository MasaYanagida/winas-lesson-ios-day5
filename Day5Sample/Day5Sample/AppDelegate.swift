//
//  AppDelegate.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NavigationMap.initialize()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("#issue application open url= \(url.absoluteString)!!")
        // URLNavigator Handler
        if NavigationMap.navigator.open(url) {
            print("#issue NavigationMap!!")
            return true
        }
        // URLNavigator View Controller
        if NavigationMap.navigator.present(url, wrap: UINavigationController.self) != nil {
            print("#issue navigator.present!!")
            return true
        }
        return false
    }
    
    /*func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print("#issue application open url= \(url.absoluteString)!!")
        // URLNavigator Handler
        if NavigationMap.navigator.open(url) {
            print("#issue NavigationMap!!")
            return true
        }
        // URLNavigator View Controller
        if NavigationMap.navigator.present(url, wrap: UINavigationController.self) != nil {
            print("#issue navigator.present!!")
            return true
        }
        return false
    }*/
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        print("#issue continue userActivity url= \(userActivity.webpageURL?.absoluteString)")
//        if let url = userActivity.webpageURL,
//            userActivity.activityType == NSUserActivityTypeBrowsingWeb {
//            print("##### Universal Linking #####\ncontinue userActivity url= \(url.absoluteString)\n########################")
//            /*if url.host?.contains("neeboor.com") ?? true {
//                return handleDeepLink(url)
//            } else {
//                // adjust link
//                return handleDeepLink(Adjust.convertUniversalLink(url, scheme: "neeboor"))
//            }*/
//        }
//        return true
//    }

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

