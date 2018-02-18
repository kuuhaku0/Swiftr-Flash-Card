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
    
    public var flashCards = [FlashCard]()
    public var categories = [Category]()
    
    public var rootRef: DatabaseReference!
    public var usersRef: DatabaseReference!
    public var categoriesRef: DatabaseReference!
    public var flashCardsRef: DatabaseReference!
    
    public func getUsersRef() -> DatabaseReference {return usersRef}
    public func getCategoriesRef() -> DatabaseReference {return categoriesRef}
    public func getFlashCardsRef() -> DatabaseReference {return flashCardsRef}
}
