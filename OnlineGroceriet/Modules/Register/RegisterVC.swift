//
//  RegisterVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift

class RegisterVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var iHaveAccountLabel: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var togglePasword: UIButton!
    @IBOutlet weak var useNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
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
        let txts = [emailTextField,passwordTextField,useNameTextField]
        txts.forEach{
            $0?.selectedTitleColor = ._7_C_7_C_7_C
            $0?.selectedLineColor = ._53_B_175
            $0?.textColor = .black
            $0?.lineColor = .c7Bcb6
            $0?.placeholder = $0?.placeholder?.capitalized
        }

        useNameTextField.setCustomFont( size: 18)
        emailTextField.setCustomFont( size: 18)
        passwordTextField.setCustomFont( size: 18)

    }

    private func setupButtons() {
        termsButton.setCustomFont(size: 14)
        privacyButton.setCustomFont(size: 14)
        logInButton.setCustomFont(size: 14)
        signUpButton.setCustomFont(size: 18)
        signUpButton.addCornerRadius(20)

    }

    private func configureKeyboardManager() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 10
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
    }
    
    // MARK: - Actions
    @IBAction func togglePaswordClicked(_ sender: UIButton) {
        isSecureTextField.toggle()
        let image = UIImage(systemName: isSecureTextField ? "eye":"eye.slash")
        sender.setImage(image, for: .normal)
        passwordTextField.isSecureTextEntry = isSecureTextField

    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let userName = useNameTextField.text ,!userName.isEmpty  else {
            displayMessage(massage: .nameEmpty)
            return
        }

        guard isValidPassword(userName) else{
            displayMessage(massage:.nameValid)
            return
        }

        guard let email = emailTextField.text ,!email.isEmpty  else {
            displayMessage(massage: .emailEmpty)
            return
        }

        guard isValidPassword(email) else{
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

    @IBAction func loginButtonClicked(_ sender: Any) {
        presentDetail(LogInVC())
    }
    
    @IBAction func termsButtonClicked(_ sender: Any) {

    }
    @IBAction func privacyButtonClicked(_ sender: Any) {

    }

    @IBAction func backButtonClicked(_ sender: Any) {
        dismissDetail()
    }
    

}
