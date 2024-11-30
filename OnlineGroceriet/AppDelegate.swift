//
//  AppDelegate.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/29/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaultsManager.shared.isBoarding {
            window?.rootViewController = OnBoardingVC()
        } else {
            window?.rootViewController = SignInViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }
}

