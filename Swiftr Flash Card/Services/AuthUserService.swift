//
//  AuthUserService.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation
import FirebaseAuth

@objc protocol AuthUserServiceDelegate: class {
    
    //Create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ userService: AuthUserService, user: AppUser)
    
    //Sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    //Sign in delegate protocols
    @objc optional func didFailSigningIn(_ userService: AuthUserService, error: Error)
    @objc optional func didSignIn(_ userService: AuthUserService, user: AppUser)
}


class AuthUserService: NSObject {
 
    weak public var delegate: AuthUserServiceDelegate?
    private var auth: Auth!
    
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(withEmail email: String, password pass: String) {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            } else if let user = user {
                let newAppUser = AppUser(uid: user.uid, email: email)
                DBService.manager.addAppUser(newAppUser)
                
                self.delegate?.didCreateUser?(self, user: newAppUser)
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(withEmail email: String, password pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                self.delegate?.didFailSigningIn!(self, error: error)
            } else if let user = user {
                DBService.manager.getAppUser(with: user.uid, completion: { (AppUser) in
                    self.delegate?.didSignIn?(self, user: AppUser)
                })
            }
        }
    }
}

