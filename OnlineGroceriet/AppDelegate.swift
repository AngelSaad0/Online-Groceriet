//
//  AppDelegate.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/29/24.
//

import UIKit
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.isEnabled = true
            IQKeyboardManager.shared.resignOnTouchOutside = true
            IQKeyboardManager.shared.keyboardDistance = 10
            IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaultsManager.shared.isBoarding {
            window?.rootViewController = OnBoardingVC()
        } else  if UserDefaultsManager.shared.isLogin{
            window?.rootViewController = MainTabBarVC()
        }else {
            window?.rootViewController = SignInViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }
}

