//
//  DBService.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

@objc protocol DBServiceDelegate: class {
    
    
}

class DBService: NSObject {
    
    private override init() {
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        flashCardsRef = rootRef.child("flashCards")
        categoriesRef = rootRef.child("categories")
        super.init()
    }
    
    static let manager = DBService()
    public weak var delegate: DBServiceDelegate?
    
    var flashCards = [FlashCard]()
    var categories = [Category]()
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var categoriesRef: DatabaseReference!
    var flashCardsRef: DatabaseReference!
    
    func getUsersRef() -> DatabaseReference {return usersRef}
    func getCategoriesRef() -> DatabaseReference {return categoriesRef}
    func getFlashCardsRef() -> DatabaseReference {return flashCardsRef}
}
