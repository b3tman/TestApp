//
//  LoginViewController.swift
//  TestApp
//
//  Created by Максим Бриштен on 15.01.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    //MARK: - Outlets
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet var textFields: [UITextField]!
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self,
                                           selector: #selector(textDidChange(_:)),
                                               name: Notification.Name.UITextFieldTextDidChange,
                                             object: nil)
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    //MARK: - Private helpers methods
    
    private func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else { return (false, nil) }
        
        switch textField {
        case loginTextField:
            return (text.count >= 6, "Your name is too short.")
        case passwordTextField:
            return (text.count >= 6, "Your password is too short.")
        default:
            return (text.count > 0, "This field cannot be empty.")
        }
    }
    
    private func animateValidationLabel(_ label: UILabel, _ valid: Bool) {
        UIView.animate(withDuration: 0.25, animations: { label.isHidden = valid })
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true
        
        for textField in textFields {
            let (valid, _) = validate(textField)
            
            guard valid else {
                formIsValid = false
                break
            }
        }
        logInButton.isEnabled = formIsValid
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            let (valid, message) = validate(textField)
            if valid {
                passwordTextField.becomeFirstResponder()
            }
            self.loginValidationLabel.text = message
            animateValidationLabel(loginValidationLabel, valid)
    
        case passwordTextField:
            let (valid, message) = validate(textField)
            if valid {
                logInButton.isHidden = false
            }
            self.passwordValidationLabel.text = message
            animateValidationLabel(passwordValidationLabel, valid)
        default:
            passwordTextField.resignFirstResponder()
        }

        return true
    }
}
