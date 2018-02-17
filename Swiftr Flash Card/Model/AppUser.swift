//
//  AppUser.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation

class AppUser: NSObject {
    let uID: String
    let email: String
    
    init(uid: String, email: String) {
        self.uID = uid
        self.email = email
    }
}
