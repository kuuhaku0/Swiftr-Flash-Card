//
//  ViewController.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // Login
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            authUserService.signIn(withEmail: email, password: password)
        } else {
            showAlert(title: "Error", message: "E-mail cannot be blank")
        }
    }
    
    private var authUserService = AuthUserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUserService.delegate = self
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - AuthUserServiceDelegate Methods
extension LoginViewController: AuthUserServiceDelegate {
    func didSignIn(_ userService: AuthUserService, user: AppUser) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    func didFailSigningIn(_ userService: AuthUserService, error: Error) {
        showAlert(title: "Error", message: "\(error)")
    }
}
