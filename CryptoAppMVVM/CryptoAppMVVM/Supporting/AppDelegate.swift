//
//  AppDelegate.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 11.10.2024.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = HomeController()
        window?.rootViewController = UINavigationController(rootViewController: initialViewController)
        window?.makeKeyAndVisible()
        
        
        print("DEBUG PRINT:", SDImageCache.shared.diskCache.totalSize())
        SDImageCache.shared.config.maxDiskSize = 1000000 * 20
        return true
    }
}
