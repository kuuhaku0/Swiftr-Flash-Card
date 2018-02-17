//
//  DBService+AppUser.swift
//  Hype Post App
//
//  Created by C4Q on 2/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    public func addAppUser(_ appUser: AppUser) {
        let ref = usersRef.child(appUser.uID)
        ref.setValue(["email": appUser.email,
                      "uID": appUser.uID])
    }
    
    func getAppUser(with uID: String, completion: @escaping (_ user: AppUser) -> Void) {
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            
            guard let email = snapshot.childSnapshot(forPath: "email").value as? String else {return}
            
            let currentAppUser = AppUser(uid: uID, email: email)
            completion(currentAppUser)
        }
    }
}
