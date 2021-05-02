//
//  AppDelegate.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
        return true
    }
}
