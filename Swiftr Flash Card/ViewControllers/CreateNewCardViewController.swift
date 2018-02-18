//
//  CreateNewCardViewController.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class CreateNewCardViewController: UIViewController {
    
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var answerTF: UITextField!
    // Create new flash card
    @IBAction func createNewCard(_ sender: UIButton) {
        DBService.manager.addFlashCard(question: questionTF.text!, answer: answerTF.text!, category: selectedCategory.name)
        showAlert(title: "Success", message: "Created new flash card in \(selectedCategory.name)")
    }
    
    public var selectedCategory: Category! {
        didSet {
            print("got category \(selectedCategory.name)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.questionTF.text = ""
            self.answerTF.text = ""
            self.resignFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
