//
//  SignupViewController.swift
//  BANEFIREBASE
//
//  Created by Bane Manojlovic on 26/04/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTexField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
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
    @IBAction func signUpTapped(_ sender: Any) {
        debugPrint("Sign up Tapped!!!")

        /// validate fileds
        let error = validateFields()
        if error != nil {
            /// show error message
            showError(error!)
        } else {
            /// create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTexField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            /// create user using FirebaseAuth method ---- ovo kasnije izvuci u posebnu metodu!!!
            createUser(firstName: firstName, lastName: lastName, userEmail: userEmail, userPassword: userPassword)
        }
        
        /// transition to home screen
        self.transtionToHomeScreen()
    }
    
    // MARK: - Methods
    /// for showing error message
    func showError(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
        errorLabel.numberOfLines = 0
    }
    
    /// for creating user in database using Firebas and Firestore methods
    func createUser(firstName: String, lastName: String, userEmail: String, userPassword: String) {
        Auth.auth().createUser(
            withEmail: userEmail,
            password: userPassword) { (result, err) in
                if let err = err {
                    ///there was an error
                    debugPrint("Error: \(err.localizedDescription)")
                    self.showError("Error creating user")
                } else {
                    ///user was create successfully
                    ///we use Firestore clasess after importing Firabase
                    let db = Firestore.firestore() //initialize instance of Cloud firestore
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data. User data couldn't be saved on database side")
                        }
                    }
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
extension SignUpViewController {
    
    // MARK: - Validation Methods
    func validateFields() -> String? {
        /// check if all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTexField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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

// MARK: - For Style/Setup methods
extension SignUpViewController {

    private func styleButton() {
        signUpButton.layer.cornerRadius = 20.0
    }

    private func setupErrorLabel() {
        errorLabel.isHidden = true
    }
}
