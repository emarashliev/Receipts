//
//  AppDelegate.swift
//  Receipts
//
//  Created by Emil Marashliev on 17.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appCoordinator = AppCoordinator()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator?.rootViewController
        window?.makeKeyAndVisible()
        appCoordinator?.start()
        
        URLCache.shared = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        return true
    }
}

