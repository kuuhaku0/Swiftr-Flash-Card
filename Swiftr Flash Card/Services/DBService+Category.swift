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
    public func addCategory(_ category: Category) {
        let ref = categoriesRef.child("categories")
        ref.setValue(["category"  : category.name,
                      "createdBy" : category.createdBy])
    }
    
    func getCategories(fromUser user: AppUser, completion: @escaping (_ categories: Category) -> Void) {
        
    }
}
