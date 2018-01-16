//
//  RegisterViewController.swift
//  TestApp
//
//  Created by Максим Бриштен on 16.01.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginValidationLabel: UILabel!
    @IBOutlet weak var enterPasswordValidationLabel: UILabel!
    @IBOutlet weak var confirmPasswordValidationLabel: UILabel!
    @IBOutlet var textFields: [UITextField]!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: Notification.Name.UITextFieldTextDidChange,
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - Private helpers methods
    
    private func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else { return (false, nil) }
        
        switch textField {
        case loginTextField:
            return (text.count >= 6, "Your name is too short.")
        case enterPasswordTextField:
            return (text.count >= 6, "Your password is too short.")
        case confirmPasswordTextField:
            return (text == enterPasswordTextField.text!, "Please, enter same password")
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
        signUpButton.isEnabled = formIsValid
    }
    
    
    //MARK: - Actions
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            let (valid, message) = validate(textField)
            if valid {
                enterPasswordTextField.becomeFirstResponder()
            }
            self.loginValidationLabel.text = message
            animateValidationLabel(loginValidationLabel, valid)
        case enterPasswordTextField:
            let (valid, message) = validate(textField)
            if valid {
                confirmPasswordTextField.becomeFirstResponder()
            }
            self.enterPasswordValidationLabel.text = message
            animateValidationLabel(enterPasswordValidationLabel, valid)
        case confirmPasswordTextField:
            let (valid, message) = validate(textField)
            if valid {
                signUpButton.isHidden = false
            }
            self.confirmPasswordValidationLabel.text = message
            animateValidationLabel(confirmPasswordValidationLabel, valid)
        default:
            confirmPasswordTextField.resignFirstResponder()
        }
        
        return true
    }
}

