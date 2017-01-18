//
//  User.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 17/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import Foundation
import FirebaseAuth

public class User: NSObject {
    var emailAddress: String = ""
    var displayName:String = ""
    var isEmailVerified: Bool = false
    var isAnonymous:Bool = true
    var photoURL:URL?
    var authProvider: AuthProvider = AuthProvider.EmailAddress
    var providerId: String = ""
    var firebaseUserId: String = ""
    
    init(firebaseUser:FIRUser, authProvider:AuthProvider) {
        self.authProvider = authProvider
        if let displayUserName = firebaseUser.displayName{
            self.displayName = displayUserName
        }
        
        if let email = firebaseUser.email{
            self.emailAddress = email
        }
        
        self.isAnonymous = firebaseUser.isAnonymous
        if let url = firebaseUser.photoURL{
            self.photoURL = url
        }
        
        self.isEmailVerified = firebaseUser.isEmailVerified
        self.firebaseUserId = firebaseUser.uid
        self.providerId = firebaseUser.providerID
    }
    
    public override var description: String{
        return "Email Address ==> \(emailAddress)\nDisplay Name ==> \(displayName)\nEmail Verified? ==> \(isEmailVerified)\nAnonymous User? ==> \(isAnonymous)\nAuthProvider ==> \(authProvider)\nProvider Id ==> \(providerId)\nFirebase User Id ==> \(firebaseUserId)";
    }
}
