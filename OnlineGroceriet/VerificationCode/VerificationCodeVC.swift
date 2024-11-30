//
//  VerificationCodeVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/30/24.
//

import UIKit

class VerificationCodeVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var supTitleLabel: UILabel!
    @IBOutlet var codeTextField: [UITextField]!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var resendButton: UIButton!
    @IBOutlet var nextButtonBottomConstraint: NSLayoutConstraint!
    // MARK: - Properties
    private var timer: Timer?
    private var countdown = 30

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotificationCenter()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
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
        codeTextField.forEach{
            $0.delegate = self
            $0.keyboardType = .numberPad
            $0.textAlignment = .center
            $0.setCustomFont(font: .gilroyMedium, size: 16)
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        if text.count > 1 {
            textField.text = String(text.prefix(1))
        }
        switch textField.tag {
        case 1:
            codeTextField[1].becomeFirstResponder()
        case 2:
            codeTextField[2].becomeFirstResponder()
        case 3:
            codeTextField[3].becomeFirstResponder()
        case 4:
            codeTextField[3].resignFirstResponder()
        default:
            break
        }
    }
    private func setupButtons() {
        nextButton.setCustomFont(font: .gilroyMedium, size: 18)
        nextButton.layer.cornerRadius = nextButton.frame.height/2

    }
    // MARK: - setupCountryPicker
    private func setupConstraints() {
        nextButtonBottomConstraint.constant = 130
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        let partialResult =  codeTextField.reduce(0) { partialResult, textField in
            partialResult + (textField.text?.count ?? 0)
        }
        if  partialResult == 4  {
            presentDetail(SelectLocationVC())

        } else {
            displayMessage(massage: .otpFail)
        }
    }

    @IBAction func resendButtonClicked(_ sender: Any) {
        resendOTP()
    }

    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        dismissDetail()
    }

    private func resendOTP() {
        displayMessage(massage: .otpResent,isError: false)
        resendButton.isEnabled = false
        resendButton.setTitle("Resend in 30s", for: .disabled)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.countdown -= 1
            self.resendButton.setTitle("Resend in \(self.countdown)s", for: .disabled)

            if self.countdown == 0 {
                timer.invalidate()
                self.resendButton.isEnabled = true
                self.resendButton.setTitle("Resend", for: .normal)
            }
        }
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
// MARK: - UITextFieldDelegate
extension VerificationCodeVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            let previousTag = textField.tag - 1
            if let previousTextField = codeTextField.first(where: { $0.tag == previousTag }) {
                previousTextField.becomeFirstResponder()
                previousTextField.text = ""
            }
        }
        return true
    }
}
