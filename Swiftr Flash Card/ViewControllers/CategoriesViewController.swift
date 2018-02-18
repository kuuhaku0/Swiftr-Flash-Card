//
//  CategoriesViewController.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBAction func createNewCategory(_ sender: UIBarButtonItem) {
        showAlert(title: "Create Category", message: "Enter category name")
    }
    
    private var categories = [Category]() {
        didSet {
            categoriesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    private func loadCategories() {
        DBService.manager.getAllCategories { (categories) in
            self.categories = categories
        }
    }
    
    func showAlert(title: String, message: String) {
        var tf = UITextField()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            tf = textField
        }
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            DBService.manager.addCategory(name: tf.text!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
}
