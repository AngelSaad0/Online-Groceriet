//
//  RegisterVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift

class LogInVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var iHaveAccountLabel: UILabel!

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!

    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var togglePasword: UIButton!
    // MARK: - Properties
    var isSecureTextField = true
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupTextFields()
        setupButtons()
        configureKeyboardManager()
    }
    private func setupLabels() {
        titleLabel.setCustomFont(size: 26)
        subTitleLabel.setCustomFont(size: 16)
        iHaveAccountLabel.setCustomFont(size: 14)
    }
    private func setupTextFields() {
        let txts = [emailTextField,passwordTextField]
        txts.forEach{
            $0?.selectedTitleColor = ._7_C_7_C_7_C
            $0?.selectedLineColor = ._53_B_175
            $0?.textColor = .black
            $0?.lineColor = .c7Bcb6
            $0?.placeholder = $0?.placeholder?.capitalized
        }
        emailTextField.setCustomFont( size: 18)
        passwordTextField.setCustomFont( size: 18)

    }
    private func setupButtons() {
        forgetPasswordButton.setCustomFont(size: 14)
        signUpButton.setCustomFont(size: 14)
        logInButton.setCustomFont(size: 18)
        logInButton.addCornerRadius(20)

    }
    private func configureKeyboardManager() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 50
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true

    }
    // MARK: - <#comment#>
    @IBAction func togglePaswordClicked(_ sender: UIButton) {
        isSecureTextField.toggle()
        let image = UIImage(systemName: isSecureTextField ? "eye":"eye.slash")
        sender.setImage(image, for: .normal)
        passwordTextField.isSecureTextEntry = isSecureTextField

    }
    @IBAction func logInButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text ,!email.isEmpty  else {
            displayMessage(massage: .emailEmpty)
            return
        }

        guard isValidEmail(email) else{
            displayMessage(massage:.emailValid)
            return
        }

        guard let password = passwordTextField.text ,!password.isEmpty  else {
            displayMessage(massage: .passwordEmpty)
            return
        }

        guard isValidPassword(password) else{
            displayMessage(massage:.passwordValid)
            return
        }

        presentDetail(SelectLocationVC())
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        presentDetail(RegisterVC())
    }

    @IBAction func forgetPasswordButtonClicked(_ sender: Any) {

    }

    @IBAction func backButtonClicked(_ sender: Any) {
        dismissDetail()
    }
    
}
