//
//  Category.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation
import Firebase

class Category {
    let name: String
    let createdBy: String
    
    init(name: String, createdBy: String) {
        self.name = name
        self.createdBy = createdBy
    }
}
