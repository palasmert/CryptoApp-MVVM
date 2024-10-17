//
//  AppDelegate.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 11.10.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = HomeController()
        window?.rootViewController = UINavigationController(rootViewController: initialViewController)
        window?.makeKeyAndVisible()
        return true
    }
}
