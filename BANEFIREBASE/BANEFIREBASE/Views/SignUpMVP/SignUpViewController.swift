//
//  SignupViewController.swift
//  BANEFIREBASE
//
//  Created by Bane Manojlovic on 26/04/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

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
