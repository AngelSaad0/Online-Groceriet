//
//  MainTabBarVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabBarAppearance()
    }
    // MARK: -  setup UI for Main TabBar
    private func setupUI() {
        let homeVC = createViewController(for: HomeVC.self, image: "home",title: "Home")
        let exploreVC = createViewController(for: ExploreVC.self, image:"explore",title: "Explore")
        let cartVC = createViewController(for: CartVC.self, image: "cart",title: "Cart")
        let favouriteVC = createViewController(for: FavouriteVC.self, image:"favourite",title: "Favourite")
        let accountVC = createViewController(for: AccountVC.self, image:"account",title: "Account")
        viewControllers = [homeVC, exploreVC, cartVC, favouriteVC,accountVC]
    }

    // MARK: -  create ViewController
    private func createViewController(for viewControllerID: UIViewController.Type, image: String,title:String) -> UIViewController {
        let vc = viewControllerID.init()
        vc.title = title

        vc.tabBarItem.image = UIImage(named: image)
        return vc
    }
    // MARK: -  setup TabBar Appearance
    private func setupTabBarAppearance() {
        let customFont = UIFont(name: Fonts.gilroyMedium.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12)
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.gray
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor._53_B_175
        ]

        // Apply text attributes globally to all tab bar items
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)

        // Customize tab bar appearance
        tabBar.tintColor = UIColor._53_B_175 // Icon and text color for selected items
        tabBar.unselectedItemTintColor = UIColor.gray // Icon and text color for unselected items
        tabBar.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = false
    }


}
