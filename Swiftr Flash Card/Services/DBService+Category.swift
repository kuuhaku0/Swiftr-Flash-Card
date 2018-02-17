//
//  DBService+Category.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    public func addCategory(name: String) {
        guard let currentUser = AuthUserService.getCurrentUser() else {print("could not get current user"); return}
        let ref = categoriesRef.childByAutoId()
        let category = Category(name: name, createdBy: currentUser.uid)
        ref.setValue(["category"  : category.name,
                      "createdBy" : category.createdBy])
    }
    
    func getCurrentUserPosts() -> [Category] {
        guard let userId = AuthUserService.getCurrentUser()?.uid else {print("cant get current users posts"); return []}
        return categories.filter{ $0.createdBy ==  userId}
    }
    
    public func getAllCategories(completion: @escaping (_ categories: [Category]) -> Void) {
        categoriesRef.observe(.value) { (dataSnapshot) in
            var categories: [Category] = []
            guard let categoriesSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for categorySnapshot in categoriesSnapshots {
                guard let categoryObject = categorySnapshot.value as? [String: Any] else {
                    return
                }
                guard let categoryName = categoryObject["category"] as? String,
                    let creator = categoryObject["createdBy"] as? String
                    else { print("error getting posts");return}
                
                let thisCategory = Category(name: categoryName, createdBy: creator)
                categories.append(thisCategory)
            }
            DBService.manager.categories = categories
            completion(categories)
        }
    }
}
