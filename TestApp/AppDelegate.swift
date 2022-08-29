//
//  AppDelegate.swift
//  TestApp
//
//  Created by Nikita Kurochka on 22.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?
        var NVC : UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        NVC = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = NVC
        window?.makeKeyAndVisible()
        AppData.shared
        
        return true
    }
}
