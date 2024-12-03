//
//  SignInViewController.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/29/24.
//

import UIKit
import IQKeyboardManagerSwift

class SignInViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet var ContinueWithSocialLabels: [UILabel]!
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var mainViewTopConstraint: NSLayoutConstraint!

    // MARK: - Properties
    var selectedCountry = "EG"
    var selectedCountryCode = "+20"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        updateViewHeightConstraint()
        setupLabels()
        setupButtons()
        setupContainerView()
        configureKeyboardManager()
    }
    private func updateViewHeightConstraint() {
        mainViewTopConstraint.constant = UIScreen.main.bounds.height*0.37
    }
    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyMedium, size: 26)
        socialMediaLabel.setCustomFont(font: .gilroyMedium, size: 16)
        countryCodeLabel.setCustomFont(font: .gilroyMedium, size: 18)
        ContinueWithSocialLabels.forEach{$0.setCustomFont(font: .gilroyMedium, size: 18)}
    }
    private func setupButtons() {
        updateCountryCodeButton(countryCode: "+20", countryFlag: "🇪🇬")

        registerButton.setCustomFont(font: .gilroyMedium, size: 18)
        registerButton.addCornerRadius(20)
        registerButton.addBorder(color: ._53_B_175, width: 2)

        loginButton.setCustomFont(font: .gilroyMedium, size: 18)
        loginButton.addCornerRadius(20)

    }
    private func setupContainerView() {
        containerViews.forEach{$0.addCornerRadius(20)}
    }
    private func configureKeyboardManager() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 50
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
    }

    private func updateCountryCodeButton(countryCode: String, countryFlag: String) {
        countryCodeLabel.text = "\(countryFlag) \(countryCode)"
    }

    // MARK: - Actions
    @IBAction func countryCodeButtonClicked(_ sender: Any) {
        presentDetail(SignInWithPhoneVC())
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        presentDetail(LogInVC())
    }

    @IBAction func registerButtonClicked(_ sender: Any) {
        presentDetail(RegisterVC())
    }

}
