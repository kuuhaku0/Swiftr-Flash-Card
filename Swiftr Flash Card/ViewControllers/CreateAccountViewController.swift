//
//  CreateAccountViewController.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // Create Account
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else {showAlert(title: "Error", message: "E-mail cannot be blank"); return}
        guard let password = passwordTextField.text else {showAlert(title: "Error", message: "Password cannot be blank"); return}
        authUserService.createUser(withEmail: email, password: password)
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private let authUserService = AuthUserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUserService.delegate = self
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in self.dismiss(animated: true, completion: nil)}
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
// MARK: - AuthUserServiceDelegate Methods
extension CreateAccountViewController: AuthUserServiceDelegate {
    func didCreateUser(_ userService: AuthUserService, user: AppUser) {
        showAlert(title: "Success", message: "Successfully created new account")
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}
