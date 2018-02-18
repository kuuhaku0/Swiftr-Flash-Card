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
    @IBAction func createNewCard(_ sender: UIButton) {
        DBService.manager.addFlashCard(question: questionTF.text!, answer: answerTF.text!, category: "something")
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    public var selectedCategory: String! {
        didSet {
            print("got category \(selectedCategory)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public static func storyboardInstance() -> CreateNewCardViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createNewCardVC = storyboard.instantiateViewController(withIdentifier: "CreateNewCardViewController") as! CreateNewCardViewController
        return createNewCardVC
    }
}
