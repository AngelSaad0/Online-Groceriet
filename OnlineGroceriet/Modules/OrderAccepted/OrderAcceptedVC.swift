//
//  OrderAcceptedVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/5/24.
//

import UIKit

class OrderAcceptedVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet var allButtons: [UIButton]!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - setup UI
    private func setupUI() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 28)
        subTitleLabel.setCustomFont(size: 16)
        allButtons.forEach{$0.setCustomFont(size: 16)}
    }
    // MARK: - Actions Methods
    @IBAction func backToHomeButtonCliked(_ sender: Any) {
        UIWindow.setRootViewController(viewController: MainTabBarVC())
    }

    @IBAction func trackButtonCliked(_ sender: Any) {
        let vc = MainTabBarVC ()
        vc.selectedIndex = 4
        UIWindow.setRootViewController(viewController: vc)
    }
}
