//
//  ViewController.swift
//  BANEFIREBASE
//
//  Created by Bane Manojlovic on 26/04/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Oultets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup Methods
    func setupUI() {
        setupButtons()
    }
    
    func setupButtons() {
        signUpButton.layer.cornerRadius = 20.0
        loginButton.layer.cornerRadius = 20.0
    }

}

