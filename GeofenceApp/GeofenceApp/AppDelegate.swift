//
//  AppDelegate.swift
//  GeofenceApp
//
//  Created by Andrii on 1/8/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let geofenceViewController = GeofenceScreenFactory().view()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = geofenceViewController
        window?.makeKeyAndVisible()
        return true
    }
}

