//
//  SignInWithPhoneVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/30/24.
//

import UIKit
import CountryPicker

class SignInWithPhoneVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var supTitleLabel: UILabel!
    @IBOutlet var countryCodeButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var nextButtonBottomConstraint: NSLayoutConstraint!

    // MARK: - Properties
    private var countryPicker:CountryPickerViewController!
    var selectedCountry = "EG"
    var selectedCountryCode = "+20"
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotificationCenter()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupTextFields()
        setupButtons()
        setupConstraints()
    }
    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyMedium, size: 26)
        supTitleLabel.setCustomFont(font: .gilroyMedium, size: 16)
    }
    private func setupTextFields() {
        phoneTextField.becomeFirstResponder()
        phoneTextField.setCustomFont(font: .gilroyMedium, size: 16)
    }
    private func setupButtons() {
        countryCodeButton.setCustomFont(font: .gilroyMedium, size: 16)
        updateCountryCodeButton(countryCode: "+20", countryFlag: "🇪🇬")
        nextButton.layer.cornerRadius = nextButton.frame.height/2

    }
    // MARK: - setupCountryPicker
    private func setupCountryPicker() {
        countryPicker = CountryPickerViewController()
        countryPicker.selectedCountry = selectedCountry
        countryPicker.delegate = self
        self.present(countryPicker, animated: true)
    }
    private func updateCountryCodeButton(countryCode: String, countryFlag: String) {
        countryCodeButton.setTitle("\(countryFlag) \(countryCode)", for: .normal)
    }

    private func setupConstraints() {
        nextButtonBottomConstraint.constant = 130
    }

    @IBAction func countryCodeButtonClicked(_ sender: Any) {
        setupCountryPicker()
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let phone = phoneTextField.text ,!phone.isEmpty else {
            displayMessage(massage: .mobileEmpty)
            return
        }
        if  isValidMobile(phone) {
            presentDetail(VerificationCodeVC())
        }else {
            displayMessage(massage: .mobileValid)

        }
    }
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        dismissDetail()
    }
    // MARK: - setNotificationCenterOnKeyBoard
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisplay), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc func keyboardHide() {
        nextButtonBottomConstraint.constant = 130
    }
    @objc func keyboardWillDisplay(notification: Notification) {
        if  let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            nextButtonBottomConstraint.constant = keyboardHeight +  30
        }
    }
}
// MARK: - CountryPickerDelegate
extension SignInWithPhoneVC: CountryPickerDelegate {
    func countryPicker(didSelect country: CountryPicker.Country) {
        selectedCountry = country.isoCode
        selectedCountryCode = country.phoneCode
        let countryFlag = country.isoCode.getFlag()
        let countryCode = "+" + country.phoneCode
        updateCountryCodeButton(countryCode: countryCode, countryFlag: countryFlag)
        countryPicker = nil
    }
}
