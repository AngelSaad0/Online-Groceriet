//
//  OnBoardingVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/29/24.
//

import UIKit

class OnBoardingVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupButtons()
    }
    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyMedium, size: 48)
        subTitleLabel.setCustomFont(font: .gilroyMedium, size: 16)
    }
    private func setupButtons() {
        getStartedButton.setCustomFont(font: .gilroyMedium, size: 18)
        getStartedButton.addCornerRadius(20)
    }
    // MARK: - Actions
    @IBAction func getStartedButtonClicked(_ sender: UIButton) {
        UserDefaultsManager.shared.isBoarding = true
        UserDefaultsManager.shared.storeData()
        UIWindow.setRootViewController(viewController: SignInViewController())
    }

}
