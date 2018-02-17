//
//  Category.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation

class Category {
    let name: String
    let createdBy: AppUser
    
    init(name: String, createdBy: AppUser) {
        self.name = name
        self.createdBy = createdBy
    }
    
    deinit {
        print("category deinitialized")
    }
}
