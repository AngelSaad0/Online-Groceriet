//
//  OrderAcceptedVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/5/24.
//

import UIKit

class OrderAcceptedVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet var allButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.setCustomFont(font: .gilroyBold, size: 28)
        subTitleLabel.setCustomFont(size: 16)
        allButtons.forEach{$0.setCustomFont(size: 16)}
    }

    @IBAction func backToHomeButtonCliked(_ sender: Any) {
        UIWindow.setRootViewController(viewController: MainTabBarVC())
    }

    @IBAction func trackButtonCliked(_ sender: Any) {
        let vc = MainTabBarVC ()
        vc.selectedIndex = 4
        UIWindow.setRootViewController(viewController: vc)
    }



}
