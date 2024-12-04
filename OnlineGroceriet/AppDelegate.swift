//
//  AppDelegate.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/29/24.
//

import UIKit
import CoreData
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
    // MARK: - Core Data stack
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "GrocerietCoreData")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        // MARK: - Core Data Saving support
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}

