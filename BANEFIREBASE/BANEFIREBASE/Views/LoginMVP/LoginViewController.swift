//
//  LoginViewController.swift
//  BANEFIREBASE
//
//  Created by Bane Manojlovic on 26/04/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

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
