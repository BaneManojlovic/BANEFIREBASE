//
//  LoginViewController.swift
//  BANEFIREBASE
//
//  Created by Bane Manojlovic on 26/04/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Style Methods
    func setupUI() {
        styleButton()
        setupErrorLabel()
    }
    
    // MARK: - Action Methods
    @IBAction func loginTapped(_ sender: Any) {
        debugPrint("Login tapped!")
        /// validate fields
        let error = validateFields()
        if error != nil {
            /// show error message
            showError(error!)
        } else {
            /// create cleande verisons of data
            let userEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userPass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            /// signing in user
            signInUser(userEmail: userEmail, userPass: userPass)
        }
    }
    
    /// for showing error message
    func showError(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
        errorLabel.numberOfLines = 0
    }
    
    func signInUser(userEmail: String, userPass: String) {
        /// signing in user
        Auth.auth().signIn(withEmail: userEmail,
                           password: userPass) { (result, error) in
                            if error != nil {
                                /// show error message
                                debugPrint("Error: \(error!.localizedDescription)")
                                self.showError("Error creating user")
                            } else {
                                /// transition to home screen
                                self.transtionToHomeScreen()
                            }
        }
    }
    
    /// for transition to home screen
    func transtionToHomeScreen() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}

// MARK: - For validation of fields
extension LoginViewController {
    
    // MARK: - Validation Methods
    func validateFields() -> String? {
        /// check if all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        /// check if password is secured
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            return "Please make sure that your password is 8 crh long, contain 1 special char and 1 number"
        }
        /// check if email is valid format
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isValid(cleanedEmail) == false {
            return "Please make sure that yout email adress is in valid format"
        }
        return nil
    }
    
    /// password validation
    func isPasswordValid(_ password : String) -> Bool{
        ///password must contain:
        ///length 8
        ///one alphabet letter
        ///one special character
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    /// email validation
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

// MARK: - For Style/Setup Methods
extension LoginViewController {
    
    private func styleButton() {
        loginButton.layer.cornerRadius = 20.0
    }
    
    private func setupErrorLabel() {
        errorLabel.isHidden = true
    }
}
